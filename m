Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRKTRir>; Tue, 20 Nov 2001 12:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281183AbRKTRi2>; Tue, 20 Nov 2001 12:38:28 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:56251 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281181AbRKTRiU> convert rfc822-to-8bit; Tue, 20 Nov 2001 12:38:20 -0500
Message-Id: <5.1.0.14.2.20011120173309.0262fd10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Nov 2001 17:37:19 +0000
To: =?iso-8859-1?Q?Lu=EDs?= Henriques 
	<lhenriques@criticalsoftware.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: copy to suer space
Cc: <linux-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200111201714.fAKHEc276467@criticalsoftware.com>
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:08 20/11/01, Luís Henriques wrote:
>When I'm modifing the code, I'm sure that the page is in memory because my
>code is called from the user space, in the exact location where I want to
>change it (with a breakpoint interruption...)

There is a time window in which it might get paged out in the mean time but 
it's admittedly a very small window. But that is irrelevant as copy_to_user 
would take care of the page out case by faulting the page back in (that is 
at least my understanding of it).

But that is not the problem I was talking about: Imagine you do 
successfully modify the user space code and AFTER THAT the kernel pages out 
the code and pages it back in later. Your change is then lost without trace.

That can easily crash your program depending on what modifications you do 
to it...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

