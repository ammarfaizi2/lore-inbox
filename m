Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbUKXG0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUKXG0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 01:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUKXG0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 01:26:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:2568 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261266AbUKXG0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 01:26:37 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87653wxqij.fsf@devron.myhome.or.jp> <20041124032017.GG8040@waste.org>
	<87pt237se1.fsf@devron.myhome.or.jp> <20041124053552.GD2460@waste.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 24 Nov 2004 15:26:06 +0900
In-Reply-To: <20041124053552.GD2460@waste.org> (Matt Mackall's message of
 "Tue, 23 Nov 2004 21:35:52 -0800")
Message-ID: <871xejvk3l.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

>> Things which I want to say here - do we really need the bogus
>> sync-mode?
>
> I'm not sure why you say it's bogus. Ext2 for instance has long had a
> mount option similar to this and it makes sense in volatile
> environments. Having the flag in the superblock seems a sensible way
> of doing it as well.

AFAIK, EXT2 doesn't update all metadata synchronously in sync-mode.

>> Current fatfs is not keeping the consistency of data on the disk at
>> all.  So, after all, the data on a disk is corrupting until all
>> syscalls finish, right?
>
> This is to protect against usage patters like mv a b, oh look, it's
> done, unplug. Not lots of active readers/writers.

I think we don't need synchronous update for it, probably we just need
to flush the buffers on each operations.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
