Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbRCSTWA>; Mon, 19 Mar 2001 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRCSTVu>; Mon, 19 Mar 2001 14:21:50 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:34999 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S131555AbRCSTVl>; Mon, 19 Mar 2001 14:21:41 -0500
From: cjw44@flatline.org.uk (Colin Watson)
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <Pine.GSO.4.21.0103161335240.12618-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0103161335240.12618-100000@weyl.math.psu.edu>
Organization: riva.ucam.org
Message-Id: <E14f5LN-0005Go-00@riva.ucam.org>
Date: Mon, 19 Mar 2001 19:29:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> wrote:
>Seriously, binfmt_misc.c was written in rather, erm, interesting C.
>Read it and you'll see. Just one (but rather impressive) example:
>
>        if ((count == 1) && !(buffer[0] & ~('0' | '1'))) {
>
>It was meant to be
>
>        if (count == 1 && (buffer[0] == '0' || buffer[0] == '1')) {
>
>and anyone who can't find the difference really should learn C. And
>that's not the only bogosity of such level. Besides, the thing is
>trivially oopsable - write() to any file in binfmt_misc with buffer
>pointing to unmapped kernel address and you are screwed,

Or you can register binfmt names that are registered already and
silently shadow old ones, or register names like 'register', 'status',
'.', and '..'. It's hideous to manage reliably from userspace.

-- 
Colin Watson                                     [cjw44@flatline.org.uk]
