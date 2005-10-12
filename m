Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVJLE7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVJLE7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 00:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVJLE7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 00:59:14 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:43268 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932445AbVJLE7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 00:59:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: machida@sm.sony.co.jp, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 12 Oct 2005 13:58:52 +0900
In-Reply-To: <20051011211601.72a0f91c.akpm@osdl.org> (Andrew Morton's message of "Tue, 11 Oct 2005 21:16:01 -0700")
Message-ID: <87psqbxreb.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> However there's not much point in writing a brand-new function when
> write_inode_now() almost does the right thing.  We can share the
> implementation within fs-writeback.c.

Indeed. We use the generic_osync_inode() for it?

> Isn't write_inode_now() buggy?  If !mapping_cap_writeback_dirty() we
> should still write the inode itself?

Indeed. It seems we should write the dirty inode to backing device's buffers.
sync_sb_inodes() too?  If so, really buggy.. I'll check it.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
