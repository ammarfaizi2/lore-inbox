Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUJKDjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUJKDjo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUJKDjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:39:44 -0400
Received: from [61.48.52.223] ([61.48.52.223]:48629 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S268664AbUJKDjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:39:42 -0400
Date: Sun, 10 Oct 2004 19:29:31 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200410110229.i9B2TVG07270@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: [PATCH?] make __bio_add_page check q->max_hw_sectors
Cc: dm-crypt@saout.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2004 10:14:16 +0200, Jens Axboe wrote:
>On Sun, Oct 10 2004, Adam J. Richter wrote:
[...]
>> 	I do not understand the intended difference between
>> the new max_hw_sectors field and max_sectors, so it is unclear
>> to me if it is a bug that my dm-crypt request_queue has
>> q->max_hw_sectors < q->max_sectors.  If q->max_hw_sectors
>> is supposed to be guaranteed to be greater than or equal
>> to q->max_sectors, then the real bug is elsewhere and my
>> patch is unnecessary.

>That's exactly correct, ->max_sectors must never be bigger than
>max_hw_sectors, that is the real bug.

	OK.  Please disregard my previous patch.  Thanks for
your clarification.

	The problem I saw was due to my mistake in merging the
2.6.9-rc3 change that added request_queue->max_sectors with one
of my local changes (replacing some fields in struct request_queue
with struct io_restrictions, a patch which I should repost one of
these days).

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
