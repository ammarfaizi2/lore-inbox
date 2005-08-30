Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVH3Rf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVH3Rf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVH3Rf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:35:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58564 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751340AbVH3Rf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:35:27 -0400
Date: Tue, 30 Aug 2005 10:35:24 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andreas Baer <andreas_baer@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory-Mapping with LFS
In-Reply-To: <430E83D8.4050509@gmx.de>
Message-ID: <Pine.LNX.4.62.0508301027590.15675@schroedinger.engr.sgi.com>
References: <430E83D8.4050509@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Andreas Baer wrote:

> What are the current file size limits for memory mapping via glibc's
> mmap() function on linux:

Its 2^wordsize - areas used for other purposes. 1-3GB on i386. A couple of 
petabytes(?) on ia64.

> - I doubt that the full 64-Bit (something within Exabyte) are available
> in practical use. Right or wrong?

You can likely map a 512 M section starting at 6GB into your 
address space.

> I've also found an old kernel-list e-mail from 2004 that says:
> "There is a limit per process in the kernel vm that prevent from
> mmapping more than 512GB of data."
> 
> - Is this still true for the current kernel?

That depends on the architecture. Certainly no problem on Itanium. 

> Let's presume the following case. I have an 8 GB file, 1 GB physical
> memory and I want to use memory mapping for that file using LFS on a
> 32-Bit machine.
> - Is it possible?
Yes. I am not sure why one would have to use LFS. This should work on any 
filesystem.

> If yes, let's presume that I have 2 or more pointers, that are
> frequently pointing to completely different places and switch the data
> they are pointing to.
> 
> - How is it managed (by the kernel)? Through the pages, that are
> mentioned in the glibc documentation above? Are these page operations
> really faster than normal random file access (lseek etc)?

Kernel gets a fault if the page pointed to is not present and reads it in 
from the file. And yes its faster because I/O is aligned and the page does 
not need to be copied from kernel to user space.
