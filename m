Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965311AbVKHDUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965311AbVKHDUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVKHDUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:20:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:41233 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965204AbVKHDUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:20:07 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] fat: Support a truncate() for expanding size
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
	<87r79ss658.fsf_-_@devron.myhome.or.jp>
	<20051107170626.4d08e8d6.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 12:19:56 +0900
In-Reply-To: <20051107170626.4d08e8d6.akpm@osdl.org> (Andrew Morton's message of "Mon, 7 Nov 2005 17:06:26 -0800")
Message-ID: <87ek5rx1ur.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>
>> +static int fat_cont_expand(struct inode *inode, loff_t size)
>
> Is it not possible to extend generic_cont_expand() so that fatfs can use it?

The generic_cont_expand() is too generic.

If "size" is block boundary, generic_cont_expand() expands the
->i_size to "size + 1", after it, the caller of it will truncate to
"size" by vmtruncate().

This sequence is not need if ->prepare_write() is cont_prepare_write().
The cont_prepare_write() will just fill the blocks with zero until
"size" if blocks is not allocated yet.

FAT is using cont_parepare_write(), so for avoiding the above extra
work, is using own version.

Probably, this version is generic only for cont_parepare_write().

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
