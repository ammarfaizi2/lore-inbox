Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSKJQQw>; Sun, 10 Nov 2002 11:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbSKJQQw>; Sun, 10 Nov 2002 11:16:52 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37792 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264940AbSKJQQu>; Sun, 10 Nov 2002 11:16:50 -0500
Subject: Re: BOGUS: megaraid changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211101453.gAAErOb10864@localhost.localdomain>
References: <200211101453.gAAErOb10864@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 16:47:48 +0000
Message-Id: <1036946868.1009.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 14:53, J.E.J. Bottomley wrote:
> > Linus - will you please stop merging plain dangerous "lets pretend we
> > never have errors" patches. I've got proper fixes for megaraid to use
> > the new_eh if you want them, but merging stuff so that people don't
> > even notice the problem is *WRONG*
> 
> This one came in through my scsi tree.  How about we fix the issue in a 
> different way:  I can add an option in SCSI to check for the new eh methods 
> and if it doesn't find any at all, panic the system saying that this driver 
> has no error handling but if you reboot with the scsi_no_error_handling option 
> it won't panic again?

I dont think panic() is needed bug a loud printk and maybe an error
return from scsi_register() would do the trick. We do however have a
couple of drivers where "pray, the firmware does all the work" is the
right answer, but they really should be setting their own handler that
delays rather than aborting/resetting/kicking offline

