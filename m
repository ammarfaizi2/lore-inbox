Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291626AbSBHQKo>; Fri, 8 Feb 2002 11:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSBHQKi>; Fri, 8 Feb 2002 11:10:38 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:11218 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291627AbSBHQKV>; Fri, 8 Feb 2002 11:10:21 -0500
Message-Id: <5.1.0.14.2.20020208160020.027998a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 16:12:57 +0000
To: M.Bakker@research-int.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Guest section DW: "Re: [PATCH] Fix floppy io ports
  reservation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1DD095B27B5AD511A0950002557C77E03C4CA4@rinlxch01.nl.resear
 ch-int.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:43 08/02/02, M.Bakker@research-int.com wrote:
>*       Reply: Guest section DW: "Re: [PATCH] Fix floppy io ports
>reservation" <1110.html>
>Hmmmm... and how do I tell those 12 faithfull  ps/2's (yep the real ones
>:model 31) still running everyday doing their job.....
>I'm afraid I haven't got the heart.......

Even if yours are affected you are unlikely to be wanting to enable PNPBIOS 
support in the kernel for them. And as long as you don't do that everything 
will continue to work as before my patch. The work around for this would be 
for the PNPBIOS driver in the kernel not to reserve ports 0x3f0 and 0x3f1 
on systems without a PNPBIOS. Thus on all recent systems PNPBIOS would take 
over 0x3f0 and 0x3f1 and  the floppy won't care and on really old systems 
PNPBIOS would not do that and hence the floppy will be happy, too, even 
though we don't reserve them. Having said that I am not convinced this is 
worth the effort as on such an old system PNPBIOS won't be doing anything, 
even if you compile it in, except for perhaps reserving ports, as there 
won't be anything supporting PNP in the system anyway...

I would tend to leave is as is (including my patch) until someone steps 
forward and actually shows a case where it breaks. From the comments so far 
I think we will never encounter such a case.

Anton

> >> ports 0x3f0 and 0x3f1 are used on certain PS/2 systems
> >> and on some very old AT clones
> >
> > [PS/2] Can you point me to the code for the PS/2 systems in question?
> > [AT] And we care because?
>You need not worry - these systems have been dead for over fifteen years.


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

