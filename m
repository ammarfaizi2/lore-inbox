Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbRENT2L>; Mon, 14 May 2001 15:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbRENT1v>; Mon, 14 May 2001 15:27:51 -0400
Received: from penguin.engin.umich.edu ([141.213.33.36]:45577 "EHLO
	penguin.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S262402AbRENT1o>; Mon, 14 May 2001 15:27:44 -0400
Date: Mon, 14 May 2001 15:27:26 -0400 (EDT)
From: Chris Wing <wingc@engin.umich.edu>
To: Khachaturov Vassilii <Vassilii.Khachaturov@comverse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: uid_t and gid_t vs. __kernel_uid_t and __kernel_gid_t
Message-ID: <Pine.LNX.4.21.0105141518001.30715-100000@penguin.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vassilii:

__kernel_uid_t is my fault. The names are confusing, but uid_t and gid_t
are NOT supposed to be different in kernel and user space.

They used to differ, and the junk in /include/linux/highuid.h is there to
handle all old programs which used the smaller (16-bit) uid_t.

Kernel code should always use uid_t as a type, except when copying data
between user and kernel space. In that case, just make sure that whatever
data structure you use is big enough to contain a Linux uid_t. (as of 2.4,
Linux uses 32-bit uid_t on all platforms) All new interfaces to user space
should use 32-bit uids, i.e. type unsigned int.

Don't use __kernel_uid_t at all in new code. The name is basically there
only because the older libc5 C library included the kernel headers and we
have to preserve it so that programs still compile on these old systems.

if you look inside /include/linux/types.h, this is made explicit:

#ifdef __KERNEL__
typedef __kernel_uid32_t	uid_t;
typedef __kernel_gid32_t	gid_t;
...
...


Thanks,

Chris Wing
wingc@engin.umich.edu

