Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVBPRQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVBPRQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVBPRQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:16:45 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:41373 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262084AbVBPRQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:16:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Xa7K+yo78lwOBM/s9Uss8XsNAVs7EoViLzbBIxIr66nCk7pk2kqiUYi023hjHGPUWWra/bOEnD5oN0Wtx8UBcUNgL+oqzQotybPKoRqHQ6jUm4O5jKoXYjF8/bAn8x6G9ERzjShO6QnytMgM7y5ojHpHtBzt9kTiLxNA3GaaC24=
Message-ID: <712fce105021609163a605f51@mail.gmail.com>
Date: Wed, 16 Feb 2005 09:16:40 -0800
From: Martin Bogomolni <martinbogo@gmail.com>
Reply-To: Martin Bogomolni <martinbogo@gmail.com>
To: linux-os@analogic.com
Subject: Re: NTFS - Kernel memory leak in driver for kernel 2.4.28?
In-Reply-To: <Pine.LNX.4.61.0502161151370.10018@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <712fce1050216082847bec092@mail.gmail.com>
	 <Pine.LNX.4.61.0502161151370.10018@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick,

I should say that the malloc() succeeds, but the 16mb I need for the
buffer are not available.  Since there is no swap/page file in the
embedded environment, there isn't enough memory left afterwards for
the buffer.

After taking another look at the problem, the kernel has a lot of
memory tied up in the inode and dentry cache.   I've tuned
/proc/sys/vm/vm_cache_scan_ratio, vm_mapped_ratio, vm_vfs_scan_ratio
with no real success in shrinking the amount of memory used by these
caches.

Is there a way to tune and shring the overall amount of memory the
kernel attempts to use for the dentry/inode cache, or make it much,
much more aggressive at clearing it?

-Martin   



On Wed, 16 Feb 2005 12:00:53 -0500 (EST), linux-os
<linux-os@analogic.com> wrote:
> On Wed, 16 Feb 2005, Martin Bogomolni wrote:
> 
> [SNIPPED...]
> 
> > after the 'find' command is run.   malloc( ) fails to allocate
> > afterwards. so the kernel does not free any of the missing RAM for
> > malloc( ).
> >
> 
> Whatever program is using malloc() is either corrupting
> its buffers or has a memory leak.
> 
> Malloc() will always succeed even if the kernel has no
> memory available. This is because the actual allocation
> only occurs when the program attempts to write to one
> of those pages malloc() "promised".
> 
> When you look at kernel memory after using `find` everything,
> the directory of everything you have accessed remains in
> memory until the kernel needs page(s) to give to processes.
> 
> So, the bottom line is, if malloc() returns NULL, you have
> a problem with your program. It has nothing to do with
> the kernel and "discovering" that the kernel has used
> all available RAM for temporary buffers is not interesting.
> 
> [SNIPPED...]
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
>
