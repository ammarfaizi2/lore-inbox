Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbUKRIR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUKRIR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUKRIR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:17:26 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:27285 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261868AbUKRIRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:17:21 -0500
To: pavel@ucw.cz
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20041117204424.GC11439@elf.ucw.cz> (message from Pavel Machek on
	Wed, 17 Nov 2004 21:44:24 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz>
Message-Id: <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 09:17:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know I've asked before... but how is the "fuse-userspace-part
> swapped out and memory full of dirty data on fuse" deadlock solved?

By either

  1) not allowing share writable mappings 

  2) doing non-blocking asynchronous writepage

In the first case there will never be dirty data, since normal writes
go synchronously through the page cache.

In the second case there is no deadlock, because the memory subsystem
doesn't wait for data to be written.  If the filesystem refuses to
write back data in a timely manner, memory will get full and OOM
killer will go to work.  Deadlock simply cannot happen.

Miklos
