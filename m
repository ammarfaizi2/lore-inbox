Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266293AbRGYAnL>; Tue, 24 Jul 2001 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266321AbRGYAnC>; Tue, 24 Jul 2001 20:43:02 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:429 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266293AbRGYAm6>; Tue, 24 Jul 2001 20:42:58 -0400
Message-Id: <5.1.0.14.2.20010725013436.00a91880@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 25 Jul 2001 01:43:03 +0100
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] Optimization for use-once pages
Cc: Rik van Riel <riel@conectiva.com.br>, <jlnance@intrex.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <01072502043009.00520@starship>
In-Reply-To: <Pine.LNX.4.33L.0107241355090.20326-100000@duckman.distro.conectiva>
 <Pine.LNX.4.33L.0107241355090.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 01:04 25/07/2001, Daniel Phillips wrote:
>At that size you'd run a real risk of missing the tell-tale multiple
>references that mark a page as frequently used.  Think about metadata
>here (right now, that usually just means directory pages, but later...
>who knows).

This is not actually implemented yet, but NTFS TNG will use the page cache 
to hold both the LCN (physical clusters) and MFT (on disk inodes) 
allocation bitmaps in addition to file and directory pages. (Admittedly the 
LCN case folds into the file pages in page cache one as the LCN bitmap is 
just stored inside the usual data of a file called $Bitmap, but the MFT 
case is more complex as it is in an additional attribute inside the file 
$MFT so the normal file read/write functions definitely cannot be used. The 
usual data here is the actual on disk inodes...)

Just FYI.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

