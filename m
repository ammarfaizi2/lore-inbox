Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSKZLEk>; Tue, 26 Nov 2002 06:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSKZLEk>; Tue, 26 Nov 2002 06:04:40 -0500
Received: from A17-250-248-85.apple.com ([17.250.248.85]:9688 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id <S264614AbSKZLEj>;
	Tue, 26 Nov 2002 06:04:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Peter Waechtler <pwaechtler@mac.com>
To: Michal Wronski <wrona@mat.uni.torun.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
Date: Tue, 26 Nov 2002 12:16:52 +0100
User-Agent: KMail/1.4.3
References: <Pine.GSO.4.40.0211261010020.24735-100000@Juliusz>
In-Reply-To: <Pine.GSO.4.40.0211261010020.24735-100000@Juliusz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211261216.52359.pwaechtler@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 26. November 2002 10:12 schrieb Michal Wronski:
> I have a few remarks/questions:
>
> 1. I can't find unregister_filesystem in your patch

I removed the unused code. I can't have a module
with it's own syscalls - posixmsg can't be a module for that reason.

> 2. You have different MQ_PRIO_MAX in library and patch.

Umh, the value is really arbitrary. Could be something like MAX_INT -1

> 3. Does mq_unlink work in a proper way?

I do think so. Did you test it and found a bug?
The vfs keeps track of a reference count. Only when the usage count
of the inode drops to zero, the mqueue_release is called. 
I tested it and it worked.
Even when there is a process in mq_receive() waiting, only the name
is removed as you expect it with unix filesystem semantics. SuSv3
explicitly allows that:

"Calls to mq_open() to recreate the message queue may fail until the message 
queue is actually removed. However, the mq_unlink() call need not block until 
all references have been closed; it may return immediately."


