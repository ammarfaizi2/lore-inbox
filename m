Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVJLECd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVJLECd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 00:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVJLECd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 00:02:33 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:36361 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932413AbVJLECc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 00:02:32 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: "Machida, Hiroyuki" <machida@sm.sony.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 12 Oct 2005 13:02:20 +0900
In-Reply-To: <20051011142608.6ff3ca58.akpm@osdl.org> (Andrew Morton's message of "Tue, 11 Oct 2005 14:26:08 -0700")
Message-ID: <87r7armlgz.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>>  /**
>> + * sync_inode_wodata - sync(write and wait) inode to disk, without it's data.
>> + * @inode: the inode to sync
>> + *
>> + * sync_inode_wodata() will write an inode  then wait.  It will also
>> + * correctly update the inode on its superblock's dirty inode lists 
>> + * and will update inode->i_state.
>> + *
>> + * The caller must have a ref on the inode.
>> + */
>> +int sync_inode_wodata(struct inode *inode)
>> +{
>> +	struct writeback_control wbc = {
>> +		.sync_mode = WB_SYNC_ALL, /* wait */
>> +		.nr_to_write = 0,/* no data to be written */
>> +	};
>> +	return sync_inode(inode, &wbc);
>> +}
>> +
>
> I think this function duplicates write_inode_now()?

write_inode_now() seems to write data pages, but this doesn't write
(.nr_to_write = 0).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
