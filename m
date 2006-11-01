Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423968AbWKAJGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423968AbWKAJGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423967AbWKAJGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:06:53 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:29777 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1423968AbWKAJGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:06:52 -0500
Message-ID: <4548639C.7070608@sw.ru>
Date: Wed, 01 Nov 2006 12:06:36 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: akpm@osdl.org
CC: viro@zeniv.linux.org.uk, devel@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: what lock protects sb->s_flags
References: <200610310700.k9V70Oti020243@shell0.pdx.osdl.net>
In-Reply-To: <200610310700.k9V70Oti020243@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> Subject: VFS: BKL is not required for remount_fs()
> 
> According to Documentation/filesystems/Locking remount_fs() does not
> require BKL.
> 
> (akpm: what lock _does_ protect sb->s_flags?)

In general s_flags is changed under sb->s_umount (write) semaphore
inside various get_sb(), fill_super() and remount_fs() filesystem functions.
Exceptions are:
1) do_emergency_remount -- where s_umount(read) is taken,
2) various filesystem error-handlers (like ext3_abort() and reiserfs_abort()),
when filesystem "remounted" to read-only without any locks.

Thank you,
	Vasily Averin
