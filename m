Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCGO5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCGO5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCGO5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:57:08 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:1288 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261270AbVCGO5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:57:03 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/29] let fat handle MS_SYNCHRONOUS flag
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<874qfqrl03.fsf_-_@devron.myhome.or.jp>
	<20050306223815.GA5827@infradead.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 07 Mar 2005 23:56:31 +0900
In-Reply-To: <20050306223815.GA5827@infradead.org> (Christoph Hellwig's
 message of "Sun, 6 Mar 2005 22:38:15 +0000")
Message-ID: <87ll8zcxnk.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>>  		mark_buffer_dirty(bh);
>> +		if (sb->s_flags & MS_SYNCHRONOUS)
>> +			sync_dirty_buffer(bh);
>
> These three lines are duplicated a lot. I think you want a helper ala:
>
> static inline void fat_buffer_modified(struct super_block *sb,
> 		struct buffer_head *bh)
> {
> 	mark_buffer_dirty(bh);
> 	if (sb->s_flags & MS_SYNCHRONOUS)
> 		sync_dirty_buffer(bh);
> }

Yes, I may want the following helper. However I'll put it as is for now.

static inline void fat_buffer_modified(struct super_block *sb,
		struct buffer_head *bh, int wait)
{
	int err = 0;
	mark_buffer_dirty(bh);
	if (wait)
		err = sync_dirty_buffer(bh);
	return err;
}
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
