Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWC1SaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWC1SaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWC1SaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:30:08 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:16137 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751205AbWC1SaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:30:06 -0500
Date: Tue, 28 Mar 2006 20:30:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85
 chips to m41t00 driver
Message-Id: <20060328203008.5910ead6.khali@linux-fr.org>
In-Reply-To: <20060328181111.GB14170@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012406.GE9560@mag.az.mvista.com>
	<20060326145840.5e578fa4.akpm@osdl.org>
	<20060328002625.GE21077@mag.az.mvista.com>
	<20060328175450.f207effa.khali@linux-fr.org>
	<20060328181111.GB14170@mag.az.mvista.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Answering your questions before I forget about them and let a week pass
again...

Anything I don't comment on, means that you were right and I agree with
you.

> > May I ask why you define separate types for the M41T81 and the M41T85,
> > when you handle both exactly the same way?
> 
> The only reason is so that its obvious that both the t81 and t85 are
> supported.  If I make it M41T81 only then I can easily see someone
> grep'ing around looking for M41T85, not finding it, and writing their
> own driver.  I don't see any harm in having both, do you?

It wastes some memory, and you may later fix something for the M41T81
and forget to fix it for the M41T85.

If your only concern is to help grepers, you can add a clear list of
supported chips either as a comment at the top of the source file, or
as Documentation/i2c/chips/m41t00. That's what we do for hardware
monitoring chips.

No big deal anyway, so the decision is up to you.

> > What you do here are basically SMBus Read Byte and SMBus Write Byte
> > transactions. The code would be much more simple if you were using the
> > i2c_smbus_read_byte_data and i2c_smbus_write_byte_data functions, which
> > take care of all the technical details.
> 
> That's true but I assumed that since I was using i2c_transfer
> earlier, I should use it here.  Is that a bad assumption?
> I do see that ds1337.c uses both types.

Bad assumption, indeed. Nothing prevents you from using the smbus
functions and the i2c functions in the same driver, as long as your
call to i2c_check_functionality covers every function you use. So,
just use whatever makes your driver easier to write.

Thanks,
-- 
Jean Delvare
