Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVCHNt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVCHNt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCHNt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:49:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:8714 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262057AbVCHNt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:49:56 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/29] FAT: Remove the multiple MSDOS_SB() call
References: <87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
	<87y8d1orah.fsf_-_@devron.myhome.or.jp>
	<87u0npor9o.fsf_-_@devron.myhome.or.jp>
	<20050307220123.GI3170@stusta.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Mar 2005 22:48:35 +0900
In-Reply-To: <20050307220123.GI3170@stusta.de> (Adrian Bunk's message of
 "Mon, 7 Mar 2005 23:01:23 +0100")
Message-ID: <874qfmdz9o.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Sun, Mar 06, 2005 at 03:56:51AM +0900, OGAWA Hirofumi wrote:
>> 
>> Since MSDOS_SB() is inline function, it increases text size at each calls.
>> I don't know whether there is __attribute__ for avoiding this.
>> 
>> This removes the multiple call.
>>...

[...]

> static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
> {
>         return sb->s_fs_info;
> }
>
> I'm quite surprised that there's any problem with it.

Whoops, actually the cause was not inline. Sorry.

    #define MSDOS_SB(x)	((struct msdos_sb_info *)(x)->s_fs_info)

was same result. This just needed my patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
