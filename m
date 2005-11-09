Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbVKIVoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbVKIVoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbVKIVoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:44:54 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:42700 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161241AbVKIVox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:44:53 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 9 Nov 2005 21:44:51 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Paulo da Silva <psdasilva@esoterica.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing file mapped data inside the kernel
In-Reply-To: <437258CD.8060206@esoterica.pt>
Message-ID: <Pine.LNX.4.64.0511092143400.19282@hermes-1.csi.cam.ac.uk>
References: <437258CD.8060206@esoterica.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Nov 2005, Paulo da Silva wrote:
> I posted about this a few days ago but got no responses
> so far! I think this should be a trivial question for those
> involved in the kernel internals. May be I didn't develop
> the problem enough to be understood.
> 
> So, here is the question reformulated.
> 
> A given file system must supply a procedure for mmap.
> 
> int <fsname>_file_mmap(struct file * file, struct vm_area_struct * vma)
> {
>   int addr;
>   addr=generic_file_mmap(file,vma);
>   <Code to access addr pointed bytes or vma->vm_start>
>   return addr;
> }
> 
> I could verify that "addr" is what is returned to the user as
> a pointer to a string of bytes that maps a file when a user
> program calls mmap or mmap2.
> 
> In the user program, I can access those bytes (read/write)
> as, for ex., a char pointer.
> 
> I don't know how to access those bytes inside the kernel
> at the point <Code to access addr pointed bytes or vma->vm_start>
> 
> First trys led the program that invoked mmap to block.
> I thought that there's something to do with a previous
>    down_write(&current->mm->mmap_sem);
> If I execute
>    up_write(&current->mm->mmap_sem);
> before accessing the data the block situation does not
> occur anymore. I would like to hear something about
> this.
> 
> Anyway, I tryed to use "copy_from_user" but I got
> garbage, not the file contents! Using "strncpy" crashes
> the kernel (UML)!
> 
> Can someone please write a fragment of code to safely
> access those bytes, copying them to and from a
> kernel char pointed area so that they are read/written
> to the file?

Why do you want to do that?  If you explain what you are trying to do it 
may be possible to help you better.  It is almost 100% certain that your 
are going about it in completely the wrong way, so please describe what 
you are trying to do...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
