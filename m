Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVHKVtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVHKVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVHKVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:49:16 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:40206 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932231AbVHKVtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:49:15 -0400
Date: Thu, 11 Aug 2005 23:49:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050811234946.0106afbe.khali@linux-fr.org>
In-Reply-To: <m3iryctaou.fsf@defiant.localdomain>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
	<m3fytgnv73.fsf@defiant.localdomain>
	<20050811215929.1df5fab0.khali@linux-fr.org>
	<m3iryctaou.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> > However,
> > EEPROMs are also often found on SMBus busses, those controller only
> > implement a subset of all possible I2C commands.
> 
> You mean one can't drive clock and data lines at will, and the
> controller (some hardware) does it instead, based on commands received
> from the program (and, for example, the program interface is parallel,
> not 2-wire serial). Right?

Partly right. Actually, most SMBus controllers work the following way:
you program a number of registers (typically SMBus transaction type,
target chip address, target register address or command, and the data to
send in the case of a write transaction), then you tell the chip to
initiate the transaction. Then you poll for the transaction to be over
(or use an interupt, but most our SMBus drivers use polling), and read
the result in some register in the case of a read transaction.

> But wait, even then does the controller really know anything about
> I^2C commands? How would it differentiate between, say, 8-bit and
> 16-bit reads? Or is it just an 8-bit EEPROM bus?

No, it is still physically a 2-wire serial bus. The limitation is due to
the fast that the SMBus controller knows of a limited number of
transactions, such as Send Byte, Read Byte, Read Word etc. If the SMBus
controller doesn't know of the SMBus command you want to use (in my
case, I2C block read), then there is no way to do it, because we have no
direct control over the serial line.

> Does it do START and STOP automatically as well?

Absolutely. The good thing is that SMBus masters are not CPU intensive,
contrary to bit-banging I2C adapters.

-- 
Jean Delvare
