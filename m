Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVL2JTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVL2JTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVL2JTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:19:15 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27917 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965123AbVL2JTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:19:14 -0500
To: cai <junjiec@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>
	<87u0ctwf93.fsf@devron.myhome.or.jp> <43B3844A.5050401@gmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 29 Dec 2005 18:19:02 +0900
In-Reply-To: <43B3844A.5050401@gmail.com> (cai's message of "Thu, 29 Dec 2005 15:38:02 +0900")
Message-ID: <87y824p8ft.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cai <junjiec@gmail.com> writes:

>>Can't we use mpage_readpage() always? IIRC, that should work fine
>>without disadvantage.
>>
> it should work, but maybe some performance loses if the
> cluster size is not page-alignment, for example, 4 sector/cluster
> in a 4KB/page system.
> because it will fall back to the block_read_full_page when
> non-adjacent block found in do_mpage_readpage, i think.
> the same applies to mpage_readpages too.

Ah, yes.

But if cluster is not fragmented it shouldn't fall back, and rather it
will get advantage.  And I guess, even if it fall back to
block_read_full_page(), it would be very trivial.

What do you think?   We may need benchmark...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
