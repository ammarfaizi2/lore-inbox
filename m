Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVADIfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVADIfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 03:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVADIfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 03:35:15 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:10760 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261561AbVADIfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 03:35:10 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
References: <41D9B1C4.5050507@zytor.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 04 Jan 2005 17:34:53 +0900
In-Reply-To: <41D9B1C4.5050507@zytor.com> (H. Peter Anvin's message of "Mon,
 03 Jan 2005 12:57:40 -0800")
Message-ID: <87d5wlmw2a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> -	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
> -	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
> +	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000U;

Actually, the ->ctime_ms is not mili seconds. The valid range is 0-199 (*10ms).
(And ->ctime is started from 2 seconds)

> -		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
> +		raw_entry->ctime_ms = inode->i_ctime.tv_nsec / 1000000U;

Ditto


BTW, do you already have any plan to use this ioctls?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
