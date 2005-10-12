Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVJLFsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVJLFsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 01:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVJLFsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 01:48:14 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:22789 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932463AbVJLFsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 01:48:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: machida@sm.sony.co.jp, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
	<87psqbxreb.fsf@ibmpc.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 12 Oct 2005 14:47:57 +0900
In-Reply-To: <87psqbxreb.fsf@ibmpc.myhome.or.jp> (OGAWA Hirofumi's message of "Wed, 12 Oct 2005 13:58:52 +0900")
Message-ID: <87irw3gub6.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

>> Isn't write_inode_now() buggy?  If !mapping_cap_writeback_dirty() we
>> should still write the inode itself?
>
> Indeed. It seems we should write the dirty inode to backing device's buffers.
> sync_sb_inodes() too?  If so, really buggy.. I'll check it.

write_inode_now() seems ok.

If !mapping_cap_writeback_dirty(), the inode is bdev_inode itself or
ram-based fs's inode, so ->write_inode() is not needed.  And if
backing_dev is ramdisk, mapping->backing_dev_info was setted the
following special bdi.

static struct backing_dev_info rd_file_backing_dev_info = {
	.ra_pages	= 0,			/* No readahead */
	.capabilities	= BDI_CAP_MAP_COPY,	/* Does contribute to dirty memory */
	.unplug_io_fn	= default_unplug_io_fn,
};
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
