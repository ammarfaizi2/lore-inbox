Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCZRmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCZRmY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 12:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCZRmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 12:42:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18570 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261193AbVCZRmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 12:42:19 -0500
Date: Sat, 26 Mar 2005 18:42:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gettimeofday call
In-Reply-To: <4de75d4e913f9c7fc93bde5ee6ec57b0@mac.com>
Message-ID: <Pine.LNX.4.61.0503261838100.9796@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503261139490.3958@yvahk01.tjqt.qr>
 <4de75d4e913f9c7fc93bde5ee6ec57b0@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suppose that calling gettimeofday() repeatedly (to add a timestamp to
>> some data) within the kernel is cheaper than doing it in userspace, is it?
>
> Well, the following daemon works on most archs that support mmap at only
[...]

Ah, it does not need to be that complex.

Just comparing two approaches:

--1--
/* KERNEL: Calling read() on a character device */
static int u_read(...) {
   ...
   gettimeofday(tv);
   enqueue_in_buffer(tv);
   ...
}

+nothing needed in userspace

--2--
/* KERNEL: No gettimeofday */

Userspace:
while(read(fd, buf, sizeof(buf)) {
    gettimeofday(&buf.tv);
    ...
}


(In either case, at some point, userspace has a timestamp.)
I think that -1- is faster it does not require an additional syscall from
userspace to sys_gettimeofday().


Jan Engelhardt
-- 
No TOFU for me, please.
