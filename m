Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSJRSPR>; Fri, 18 Oct 2002 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265538AbSJRSPR>; Fri, 18 Oct 2002 14:15:17 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:49293 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265537AbSJRSPQ>;
	Fri, 18 Oct 2002 14:15:16 -0400
Message-ID: <3DB05122.9010401@colorfullife.com>
Date: Fri, 18 Oct 2002 20:21:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, Jakub Jelinek <jakub@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 04:14, Andrea Arcangeli wrote:
> the main reason it wasn't backported to i386 is that if glibc start
> using the vgettimeofday instead of sys_gettimeofday, you won't be able
> to downgrade kernel anymore to say 2.4 (oh yeah, I would then backport
> it to my tree or Marcelo could apply the patches too to 2.4 but then 2.2
> would be left uncovered, new glibc would segfault on the old kernels).

Does that problem actually exist?

http://marc.theaimsgroup.com/?l=linux-kernel&m=103253890431473&w=2

Jakub Jelinek <jakub@redhat.com> wrote on 2002-09-20 16:15:25

> glibc supports .note.ABI-tag notes for libraries, so there is no problem
> with having NPTL libpthread.so.0 --enable-kernel=2.5.36 in say
> /lib/i686/libpthread.so.0 and linuxthreads --enable-kernel=2.2.1 in
> /lib/libpthread.so.0. The dynamic linker will then choose based
> on currently running kernel.
> (well, ATM because of libc tsd DL_ERROR --without-tls ld.so cannot be used
> with --with-tls libs and vice versa, but that is beeing worked on).
> 

It should be possible to have one library that supports both syscall 
interfaces for gettimeofday().

--
	Manfred

