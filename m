Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUEAX4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUEAX4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUEAX4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:56:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:30137 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbUEAX4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:56:00 -0400
Date: Sat, 1 May 2004 16:55:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <20040501161035.67205a1f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 May 2004, Andrew Morton wrote:
> 
> Maybe we should change __syscall_return() to return the -ve errno rather
> than -1?

Yes. Except we should probably only do this for __KERNEL_SYSCALLS__, since
it's possible that somebody is still using this in user space (it
pre-glibc people).

So maybe a

	#undef __syscall_return
	#define __syscall_return(type, res)	return (type)(res);

inside the __KERNEL_SYSCALLS__ area?

		Linus
