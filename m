Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDBTxo>; Mon, 2 Apr 2001 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDBTxe>; Mon, 2 Apr 2001 15:53:34 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:52218 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S131157AbRDBTxc>;
	Mon, 2 Apr 2001 15:53:32 -0400
To: kaos@ocs.com.au
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt) 
X-Newsgroups: linux.kernel
In-Reply-To: <1140.986129422@ocs3.ocs-net>
From: chip@valinux.com (Chip Salzenberg)
In-Reply-To: <E14jdkF-0007Ps-00@tytlal>
Organization: NASA Calendar Research
Cc: linux-kernel@vger.kernel.org
Message-Id: <E14kAK3-0008UM-00@tytlal>
Date: Mon, 02 Apr 2001 12:49:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to kaos@ocs.com.au:
>chip@valinux.com (Chip Salzenberg) wrote:
>>Why not have a kernel thread and use standard RPC techniques like
>>sockets?  Then you'd not have to invent anything unimportant like
>>Yet Another IPC Technique.
>
>kerneld (kmod's late unlamented predecessor) used to use Unix sockets
>to communicate from the kernel to the daemon.  It forced everybody to
>link Unix sockets into the kernel but there are some people out there
>who want to use it as a module.  Also the kernel code for communicating
>with kerneld was "unpleasant", see ipc/msg.c in a 2.0 kernel.

I see.

On the other hand, file-style (e.g. /proc-style) access works in Plan9
at least inpart because each client makes his own connection to the
server.  Thus, the question of how clients know which response is for
them is trivially solved.  ('Server' would in this case be the JFS
kernel thread.)

Sockets are apparently not the right way to go about getting
transaction support for kernel threads.

AFAIK, Alex Viro's idea of bindable namespaces provides effective
transaction support *ONLY* if there are per-process bindings.  With
per-process bindings, each client that opens a connection does so
through a distinct binding; when that client's responses go back
through the same binding, only that client can see them.

I hope that Alex's namespaces patch, implementing per-process
bindings, goes into the official kernel Real Soon Now.
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
