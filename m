Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291090AbSBHAFH>; Thu, 7 Feb 2002 19:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291123AbSBHAE6>; Thu, 7 Feb 2002 19:04:58 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:61128 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291090AbSBHAEr>; Thu, 7 Feb 2002 19:04:47 -0500
Message-Id: <5.1.0.14.2.20020207231937.00b0cec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 00:04:48 +0000
To: Guest section DW <dwguest@win.tue.nl>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Fix floppy io ports reservation
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020207202452.GA1527@win.tue.nl>
In-Reply-To: <E16Yevs-00054g-00@libra.cus.cam.ac.uk>
 <E16Yevs-00054g-00@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:24 07/02/02, Guest section DW wrote:
>On Thu, Feb 07, 2002 at 03:09:08AM +0000, Anton Altaparmakov wrote:
> > Below is a patch that fixes the io ports reservation of the floppy driver
> > as the one in the driver is actually incorrect and this clashes with the
> > (correct) reservation by the PNPBIOS driver.
> >
> > I asked a friend to check and on his Windows 2000 system the port
> > reservation was 0x3f2-0x3f5 + 0x3f7, i.e. it just excludes ports
> > 0x3f0-0x3f1, which are NOT used anywhere in the driver anyway.
>
>ports 0x3f0 and 0x3f1 are used on certain PS/2 systems

Can you point me to the code for the PS/2 systems in question? I fail to 
see instances where anything less than 0x3f2 is used. Assuming such code is 
present and I have just missed it, perhaps we can find a way to detect such 
cases and only then register the ports.

>and on some very old AT clones

And we care because? AT = 80286 CPU in the definition I am aware of, which 
Linux doesn't support and catering for unsupported hardware seems silly. 
(-; But perhaps you meant something else by "AT clones"?

btw. Today I got a chance to check Windows XP Pro and that like Win2k only 
uses ports 0x3f2-0x3f5 and 0x3f7. As I have never heard of anyone 
complaining their floppy doesn't work with Windows (except for that Tyan 
BIOS bug a few years ago that is...), it would appear it is quite safe to 
do the same in the linux floppy driver...

FYI: Just skimmed through the WinXP floppy source (what a windows driver is 
not closed source? YES, it is in the DDK, they obviously don't think it 
worth hiding...(-:). Anyway, they never use 0x3f0-0x3f1 either AFAICS and 
in fact there is an interesting comment in the source:

---quote from pdc.c---
     The PC97(98) hardware specification defines only 3f2, 3f4, and 3f5 as
     io port resources for standard floppy controllers (based on IBM PC floppy
     controller configurations).  In addition to these resources, fdc.sys
     requires 3f7 for disk change detection and data rate programming and
     optionally 3f3 for floppy tape support.  In addition, some bioses define
     aliased resources (e.g. 3f2 & 7f2, etc.)
---end of quote---

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

