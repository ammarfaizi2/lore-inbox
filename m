Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965480AbWJ3JIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbWJ3JIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965483AbWJ3JIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:08:39 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:11132 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S965480AbWJ3JIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:08:37 -0500
Message-ID: <4545C110.8080204@qumranet.com>
Date: Mon, 30 Oct 2006 11:08:32 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [PATCH][RFC] KVM: prepare user interface for smp
 guests
References: <4544AD24.4040801@qumranet.com> <200610300101.11245.arnd@arndb.de>
In-Reply-To: <200610300101.11245.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2006 09:08:36.0747 (UTC) FILETIME=[FB92BDB0:01C6FC02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> Separating the objects into different file descriptors sounds like a
> good idea, but reusing an open dentry/inode with a new file and different
> file operations is a rather unusual way to do it. 

Yes, it doesn't feel right.

> Your concept of allocating
> a new context on each open is already weird, but there have been other
> examples of that before.
>   

Actually that seemed to me quite natural.

> I'd suggest going to a syscall-based model with your own file system right
> away, even if you don't use the spufs approach but something in the middle:
>
> * You do a trivial nonmountable new file system with anonymous objects,
>   similar to eventpollfs, and hand out file descriptors to inodes in it,
>   for both the kvm and the vcpu objects.
> * You replace the syscall you'd normally use to hand out a new kvm instance
>   with an ioctl on /dev/kvm, and don't allow any other operations on that
>   device.
>
> This would be a much more consistant object model, compared with other
> generic kernel functionality that is not bound to an actual device.
> You still have all the flexibility of a loadable module without core
> kernel changes for the development phase, and can easily switch to real
> syscalls when merging it into mainline.
>   

I agree, that sounds like a good plan.  I'll look into it.

BTW, what does lsof show for spufs users?  I thought lsof /dev/kvm would 
be a good way to look for virtual machines.


-- 
error compiling committee.c: too many arguments to function

