Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUCPTOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUCPTOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:14:34 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:10508 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261396AbUCPTOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:14:23 -0500
Date: Tue, 16 Mar 2004 20:14:26 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>, Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client
 isolation
Message-Id: <20040316201426.1d01f1d3.khali@linux-fr.org>
In-Reply-To: <20040316154454.GA13854@kroah.com>
References: <4056C805.8090004@convergence.de>
	<20040316154454.GA13854@kroah.com>
Reply-To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, right now it's up to the chip drivers to be honest.  If you want
> to implement a change to do this instead, I'll be glad to apply it.

Does this mean that i2c_client would get an additional ".class" struct
element, of the same nature of the ".class" struct element of
i2c_adapter?

This sounds interesting. That way, the "compatibility" check would move
down to i2c-core and neither the bus drivers nor the chip drivers would
have to care (apart from defining this .class element). Sounds really
nice indeed.

I guess that chip drivers would be allowed to define only one class
while adapters could possibly define more than one?

We also would want to introduce an I2C_ADAP_CLASS_ANY define, which
would be what the eeprom driver would use, for example (since it can be
hosted on any kind of bus). Generic bus drivers such as i2c-parport
would also use I2C_ADAP_CLASS_ANY, since the nature of the hosted chips
is unknown.

Having clients define a class sounds also interesting from a
user-space's point of view. If we would export this information through
sysfs for example, programs such as "sensors" could limit their work to
chips of the correct class (I2C_ADAP_CLASS_SMBUS at the moment, but a
renaming is planned).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
