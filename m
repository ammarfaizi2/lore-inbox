Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVHKQ4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVHKQ4Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVHKQ4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:56:24 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:15624 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751122AbVHKQ4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:56:23 -0400
Date: Thu, 11 Aug 2005 18:56:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050811185651.0ca4cd96.khali@linux-fr.org>
In-Reply-To: <42FA89FE.9050101@cetrtapot.si>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hinko,

> > Could you try running "i2cdump 0 0x50" and "i2cdump 0 0x50 i" (with
> > the patch still applied), and compare both the outputs and the time
> > each command takes? You should see similar outputs, but the second
> > command should be magnitudes faster. This would confirm that the I2C
> > block mode works as intended on your VT8233 chip.
> 
> Hmm, not really. Here it takes 6 seconds for the first test nad about
> 5 seconds  for the second test (I just read the WARNING - need to
> substract 5s from the  results...).

With a recent version of i2cdump (2.8.8 or later), you can use the -y
flag, which will skip this delay. This is very convenient for timing
tests.

That being said...

> noa xtrm # time i2cdump 0 0x50
> (...)
> real	0m6.033s
> (...)
> noa xtrm # time i2cdump 0 0x50 i
> (...)
> real	0m5.174s

This is 1.033s down to 0.174s. This is just great, I2C block reads work
and allow faster dumps, as expected.

> while simple cat takes a lot less time:
> noa xtrm # time dd if=/sys/bus/i2c/devices/0-0050/eeprom bs=4

This goes through the eeprom driver, which has an internal cache, so the
results are not suitable for timing comparisons.

Thanks a lot for the testing again :)
-- 
Jean Delvare
