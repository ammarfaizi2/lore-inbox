Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVIONP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVIONP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVIONP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:15:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41483 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1030403AbVIONP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:15:57 -0400
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime)
References: <43288A84.2090107@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 15 Sep 2005 22:15:44 +0900
In-Reply-To: <43288A84.2090107@sm.sony.co.jp> (Hiroyuki Machida's message of "Thu, 15 Sep 2005 05:39:32 +0900")
Message-ID: <87oe6uwjy7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:

> +	if ( (!error) && IS_SYNC(inode)) {
> +		error = write_inode_now(inode, 1);
> +	}

We don't need to sync the data pages at all here. And I think it is
not right place for doing this.  If we need this, since we need to see
O_SYNC for fchxxx() VFS would be right place to do it.

But, personally, I'd like to kill the "-o sync" stuff for these
independent meta data rather. Then...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
