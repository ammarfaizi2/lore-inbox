Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281168AbRKTRD1>; Tue, 20 Nov 2001 12:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281169AbRKTRDR>; Tue, 20 Nov 2001 12:03:17 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:33713 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281168AbRKTRDP>; Tue, 20 Nov 2001 12:03:15 -0500
Message-Id: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Nov 2001 17:02:00 +0000
To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: copy to suer space
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0111201637420.13674-100000@mail.deis.isec.pt
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:40 20/11/01, Luis Miguel Correia Henriques wrote:
>I'm trying to implement a kernel module that will be changing a user
>process' code segment. I tried to user copy_to_user to patch the process's
>code but, when I tried to read the new code (just to check...), it didn't
>worked. Why was that? And what is the solution?

I don't think what you are trying to do is possible. Even if you somehow 
managed to write over the code segment of a user space process (which I 
very much doubt would be possible as I assume the memory is mapped 
read-only), as soon as the kernel pages out (i.e. discards!) some portion 
of the executable due to memory shortage your changes would be lost, since 
the paging back into memory would happen by reading the executable back 
from disk, which would mean it would read the unmodified code into memory...

Why would you want to do such a thing anyway? Kernel modifying userspace 
binaries in memory sounds like a really flawed idea which is just begging 
for problems. - Just recompiling the user space program with the smallest 
change would make the new binary code incompatible with your predefined 
module...

But perhaps I misunderstood you?

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

