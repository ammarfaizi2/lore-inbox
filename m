Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTGGPlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTGGPlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:41:02 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:778 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265025AbTGGPlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:41:00 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sancho Dauskardt <sda@bdit.de>, linux-kernel@vger.kernel.org
Subject: Re: FAT statfs loop abort on read-error
References: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
	<20030706102410.2becd137.rddunlap@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Jul 2003 00:54:48 +0900
In-Reply-To: <20030706102410.2becd137.rddunlap@osdl.org>
Message-ID: <87u19ypc1j.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On Fri, 04 Jul 2003 13:57:19 +0200 Sancho Dauskardt <sda@bdit.de> wrote:
> |   when calling statfs on a volume that has been removed (without umount) 
> | fat_statfs() will attempt to read all sectors of the fat table quite a few 
> | times (depending on the fat type, eg. FAT16 --> 256 times).

Yes, fat driver of 2.4 ignore the many errors.

> | Possible solution:
> | 1. let default_fat_access return something like -2 on 'can't read' error.
> | 2. Abort stafs loop on error.
> | 3. return -EIO
> | 
> | This would break mode fat_access calls. I could make a patch, but I don't 
> | know what's going on with those cvf extensions (which seem to replace 
> | fat_access). Is dmsdos dead / can we ignore it ?
> | Somewhere in the list archives, I found comments about the cvf stuff being 
> | completely removed ?

I don't know anybody ported dmsdos to 2.4. The cvf stuff was removed
and many error handlings was fixed on 2.5.x. So, personally I think to
remove the cvf stuff and backport the some parts of fat driver to 2.4
is good.

> (I asked him to add a patch to MAINTAINTERS...)

Thank you. But honestly, I may not have skill enough.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
