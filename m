Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRDEAM2>; Wed, 4 Apr 2001 20:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDEAMS>; Wed, 4 Apr 2001 20:12:18 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:25072 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S132536AbRDEAMO>; Wed, 4 Apr 2001 20:12:14 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A08@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: alan@lxorguk.ukuu.org.uk
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: RE: vmalloc on 2.4.x on ia64
Date: Wed, 4 Apr 2001 18:11:32 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am calling during initialization only from detect() entry point.
But I guess, before the detect() is called, scsi layer acquires
the io_request_lock. So, you mean to say that I need to release it
before calling vmalloc() ? I was doing the same thing on 2.2.x
and even on 2.4.0 and it was working fine and now suddenly
it stopped working on 2.4.2. So what are the guidelines for using
vmalloc() if we want to use it in scsi low-level (HBA) driver ?
I am currently using the new error handling code. (use_new_eh_code = TRUE).

Regards,
-hiren

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, April 04, 2001 5:03 PM
> To: hiren_mehta@agilent.com
> Cc: Matt_Domsch@Dell.com; linux-kernel@vger.kernel.org
> Subject: Re: vmalloc on 2.4.x on ia64
> 
> 
> > Can we call vmalloc() or get_free_pages() from scsi 
> low-level driver 
> > (HBA driver) ? The reason why I am asking is because, I am calling
> 
> It depends where. You can call it during initialisation if 
> you arent holding
> the io_request_lock for example.
> 
