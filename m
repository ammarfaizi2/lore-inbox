Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUK0Gnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUK0Gnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUK0GlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:41:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65215 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261859AbUKZTLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:11:38 -0500
Date: Thu, 25 Nov 2004 21:28:33 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: sct@redhat.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: 2.4.28-bk3 ext3 oopses at boot
Message-ID: <20041125212833.0ff3af4f@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guys:

I keep getting pretty random oopses at boot which point at either ext3 or
the SATA. This is a Dell PE750 which Matt sent me, BTW. So, it's SATA-only
and I had to use Jeff's patches to get ____request_resource. This, I suppose
makes this suspect, but if the box passes the boot, everything is peachy.
No filesystem corruption of any kind.

Failures are generally random, and they look like this (transcribed by hand):

VA NULL (0x0c)
EIP: write_one_revoke_record
journal_commit_transaction
scrup
vgacon_cursto
clear_selection
poke_blanked_console
vt_console_print
schedule
__call_console_drivers
release_console_sem
kjournald

VA 0x89e389d5
EIP: find_revoke_record
journal_cancel_revoke
do_get_write_access
journal_alloc_journal_head
ext3_mark_inode_dirty
journal_get_write_access
ext3_add_entry
start_this_handle
new_handle
ext3_add_nondir
ext3_mknod
vfs_mknod
unix_bind
sys_bind
dput
sys_socketcall

The EIP is always in something related to jbd.

A self-built 2.4.21-20.EL works dandy, so this ought to rule out the
a toolchain problem (it's RHEL3 with gcc-3.2). There was a small bunch
of changes in jbd and ext3 since then, but nothing in revoke.c.

I dunno if this report has any value, but thought I'd add a data point.

-- Pete
