Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRDEBGI>; Wed, 4 Apr 2001 21:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDEBF5>; Wed, 4 Apr 2001 21:05:57 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:18655 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S132109AbRDEBFs>; Wed, 4 Apr 2001 21:05:48 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A09@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: alan@lxorguk.ukuu.org.uk
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: RE: vmalloc on 2.4.x on ia64
Date: Wed, 4 Apr 2001 19:05:04 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dropping the io_request_lock around vmalloc worked great.
Thanks for all the help. I really appreciate it.

Thanks 
-hiren

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, April 04, 2001 5:29 PM
> To: hiren_mehta@agilent.com
> Cc: alan@lxorguk.ukuu.org.uk; Matt_Domsch@Dell.com;
> linux-kernel@vger.kernel.org
> Subject: Re: vmalloc on 2.4.x on ia64
> 
> 
> > I am calling during initialization only from detect() entry point.
> > But I guess, before the detect() is called, scsi layer acquires
> > the io_request_lock. So, you mean to say that I need to release it
> 
> That depends if your driver is doing old or new style initialization
> 
> > before calling vmalloc() ? I was doing the same thing on 2.2.x
> > and even on 2.4.0 and it was working fine and now suddenly
> > it stopped working on 2.4.2. So what are the guidelines for using
> > vmalloc() if we want to use it in scsi low-level (HBA) driver ?
> 
> You can use vmalloc in any situation where you are in task context
> and can sleep.
> 
> > I am currently using the new error handling code. 
> (use_new_eh_code = TRUE).
> 
> Then yes you would need to drop the lock if my memory serves 
> me rightly.
> 
