Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVCFWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVCFWpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVCFWnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:43:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6565 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261586AbVCFWiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:17 -0500
Date: Sun, 6 Mar 2005 22:38:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/29] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20050306223815.GA5827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <87ll92rl6a.fsf@devron.myhome.or.jp> <87hdjqrl44.fsf@devron.myhome.or.jp> <87d5uerl2j.fsf_-_@devron.myhome.or.jp> <878y52rl17.fsf_-_@devron.myhome.or.jp> <874qfqrl03.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874qfqrl03.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		mark_buffer_dirty(bh);
> +		if (sb->s_flags & MS_SYNCHRONOUS)
> +			sync_dirty_buffer(bh);

These three lines are duplicated a lot. I think you want a helper ala:

static inline void fat_buffer_modified(struct super_block *sb,
		struct buffer_head *bh)
{
	mark_buffer_dirty(bh);
	if (sb->s_flags & MS_SYNCHRONOUS)
		sync_dirty_buffer(bh);
}

