Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVHRHyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVHRHyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVHRHyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:54:10 -0400
Received: from smtp.istop.com ([66.11.167.126]:14554 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932123AbVHRHyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:54:08 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Guillermo =?iso-8859-1?q?L=F3pez_Alejos?= <glalejos@gmail.com>
Subject: Re: Documenting the VFS
Date: Thu, 18 Aug 2005 17:55:02 +1000
User-Agent: KMail/1.7.2
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
References: <4fec73ca05081312054f1d1dd9@mail.gmail.com>
In-Reply-To: <4fec73ca05081312054f1d1dd9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200508181755.04163.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 August 2005 05:05, Guillermo López Alejos wrote:
> Hi,
>
> I'm writing documentation about the VFS.

Best of luck.  It is a complex topic, but if you manage to produce an accurate 
reference, it will be widely read.

> More concretely, I want to 
> document the following information about the methods defined in the
> VFS interface (i.e. the struct *_operations):
>     - Prototype.
>     - Description (brief description of what the method has to do).
>     - Description of the parameters (explanation of the purpose of
> each parameter).
>     - Return value (including possible error values).
>     - Responsibility (what the method is expected to do, including
> specific cases).
>     - Default method (is there any method that can be used instead of
> defining a new one?)
>     - Mandatory (Is the method mandatory? or it can be assigned a NULL?)

Locking is a crucial topic.  Filesystem developers need to understand what 
locking the VFS does for them and what they must do themselves.  You need to 
cover this method by method and lock by lock.  Also note that you can't 
really understand the vfs separately from things like the page cache, inode 
cache and dentry cache, and respective operations.  It crosses over into 
virtual memory topics too, because of mmap.  A discussion of the vfs would 
not be complete without discussing the life cycles of all the objects 
involved.

> It is rather difficult to find this information by looking at the
> kernel sources, and the documentation I have found does not provide
> the details I'm looking for.

You pretty much have to read the source to learn this since there is no 
authoritative reference.  As others have mentioned, Richard Gootch's vfs.txt 
document is helpful.  It is several years out of date though, and doesn't 
cover things like aio, new security hooks, dnotify and inotify event 
interface, cluster hooks, etc. etc.

> Where can I found an up to date documentation about the VFS interface?

It's pretty sparse.

   http://lxr.linux.no/source/Documentation/filesystems/vfs.txt
   http://lxr.linux.no/source/Documentation/filesystems/Locking
   http://www.faqs.org/docs/kernel_2_4/lki-3.html
   http://www.oreilly.com/catalog/linuxkernel/
   http://lwn.net

> If there is no such document, which is the correct mailing list to
> submit my questions at?

This is the right place, or fsdevel, or both.  You probably want to post your 
drafts or pointers to your drafts here for corrections and additions.

> Is there any IRC channel to chat about this? 
> (I have visited a couple of times #kernelnewbies).

#kernelnewbies is good, the name is a little deceiving.  Also, try Matt 
Mackall's kernelmentors mailing list and Arnaldo Carvalho de Melo's kernel 
janitors mailing list.

> Thanks for your help and regards,

Thanks for volunteering!

Regards,

Daniel
