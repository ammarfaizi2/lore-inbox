Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVD2TOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVD2TOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVD2TOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:14:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30379 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262891AbVD2TL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:11:29 -0400
In-Reply-To: <Pine.LNX.4.60.0504290824280.28101@hermes-1.csi.cam.ac.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: aia21@hermes.cam.ac.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, mike.miller@hp.com
MIME-Version: 1.0
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF48BA3721.BD4798AD-ON88256FF2.00680E7E-88256FF2.0069814F@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 29 Apr 2005 12:11:24 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/29/2005 15:11:27,
	Serialize complete at 04/29/2005 15:11:27
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 28 Apr 2005, Bryan Henderson wrote:
>> >O_SYNC doesn't work completely on several file systems and only on the
>> >latest kernels with some of the common ones.
>> 
>> Hmmm.  You didn't mention such a restriction when you suggested fsync() 

>> before.  Does fsync() work completely on these kernels where O_SYNC 
>> doesn't?  Considering that a simple implementation of O_SYNC just does 
the 
>> equivalent of an fsync() inside every write(), that would be hard to 
>> understand.
>
>Some file systems implement their fsync() function as "return 0;" so no, 
>you cannot rely on it at all.

It's pretty clear Alan isn't talking about those cases.  I don't think he 
would have suggested fsync() to address the delayed write error problem in 
a case where fsync() is "return 0;".

But let's talk about the no-op fsync() cases:  fsync() is supposed to 
cause data to be written to stable storage.  "stable" is a relative 
concept that the individual filesystem type or driver has to define for 
itself.  In an ordinary disk-based filesystem, we usually expect it to 
mean the data has gone onto the oxide.  But that's not really stable -- 
the disk drive could break and the data would be gone.  For some, just 
getting into the buffers of the disk drive is stable enough, since then 
rebooting Linux wouldn't cause the data to be lost.  For ramfs, the Linux 
page cache is as stable as you can hope for.

So I view it as correct even if fsync() does nothing on a disk-based 
filesystem because the programmer was lazy (or because the user wants to 
defeat the performance-busting behavior of some paranoid application). But 
when Alan speaks of a "not completely correct" version of synchronization, 
which makes me think of something that doesn't implement any consistent 
form of "stable," I want to hear more.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
