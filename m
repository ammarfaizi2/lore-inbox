Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVHLG0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVHLG0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 02:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHLG0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 02:26:18 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:1036 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751141AbVHLG0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 02:26:17 -0400
Date: Fri, 12 Aug 2005 08:26:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050812082653.098a6aa3.khali@linux-fr.org>
In-Reply-To: <m3br44t9cv.fsf@defiant.localdomain>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
	<m3fytgnv73.fsf@defiant.localdomain>
	<20050811215929.1df5fab0.khali@linux-fr.org>
	<m3iryctaou.fsf@defiant.localdomain>
	<20050811234946.0106afbe.khali@linux-fr.org>
	<m3br44t9cv.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> So, with one transaction, can I write an arbitrary number of bytes to
> the device, and then, in the same transaction, can I read one (or no,
> or with some controllers, more than one) byte(s) back?

In I2C mode, you can even alternate as many read and write sequences you
want in a single transaction. The target chip would of course need to
know how to interpret such a transaction though. I've never seen this
possibility used so far.

In SMBus mode, you are limited by the transaction types that have been
defined, but a number of them are composed of a write transaction and a
read transaction (separated by what is known as a "repeated start").
Read Byte, Read Word, Read Block and Read I2C Block are such
transactions. See the SMBus specification for the details.

> Interesting. Still, that limits it to 8-bit-addressable EEPROMs.

Depends on the SMBus. A SMBus controller could implement 16-bit address
I2C block transfers. I don't think I saw one do so far, but it's still
possible in theory.

Also note that this can easily be emulated using a Write Byte command
(which writes 2 bytes on the bus) to set the 16-bit addressed EEPROM
offset, then using continuous Receive Byte commands to get the data.
This is of course slower than a block read though.

> Are such things documented somewhere on the net (some datasheet
> maybe)?

The I2C specifications are available from Philips. The SMBus
specifications are available from smbus.org. Intel also has good
datasheets for all ICH chips.

http://www.semiconductors.philips.com/markets/mms/protocols/i2c/
http://www.smbus.org/specs/

More generally, see the lm_sensors project's links page:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/useful_addresses.html
and also:
http://secure.netroedge.com/~lm78/docs.html

Hope that helps,
-- 
Jean Delvare
