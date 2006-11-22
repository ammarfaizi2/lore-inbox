Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756721AbWKVTaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbWKVTaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756722AbWKVTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:30:00 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:20437 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1756721AbWKVT37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:29:59 -0500
X-AuthUser: hirofumi@parknet.jp
To: The Peach <smartart@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
	<8764d7v4nh.fsf@duaron.myhome.or.jp>
	<20061122201008.17072c89@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 04:29:15 +0900
In-Reply-To: <20061122201008.17072c89@localhost> (The Peach's message of "Wed\, 22 Nov 2006 20\:10\:08 +0100")
Message-ID: <87r6vvs2k4.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Peach <smartart@tiscali.it> writes:

> On Thu, 23 Nov 2006 01:15:46 +0900
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> Thanks. Probably instead of some overheads, this patch will fix a problem.
>
> here it is, did the very same experiments than before.
> Normal file:
> # cp -v DSCN5970\(1\).JPG /mnt/loop/
> `DSCN5970(1).JPG' -> `/mnt/loop/DSCN5970(1).JPG'
>
> dmesg:
> vfat_hashi: parent d1801e94, parent->d_op e0fbc620
> vfat_hashi: parent /, name DSCN5970(1).JPG
> vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
> vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
> vfat_revalidate: name DSCN5970(1).JPG, nd d65eaeec, flags 00000001
> vfat_lookup: name DSCN5970(1).JPG
> vfat_hashi: parent d1801e94, parent->d_op e0fbc620
> vfat_hashi: parent /, name DSCN5970(1).JPG
> vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
> vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
> vfat_revalidate: name DSCN5970(1).JPG, nd d65eaf24, flags 00000300
> vfat_lookup: name DSCN5970(1).JPG
> vfat_create: name DSCN5970(1).JPG
> vfat_add_entry: 0: DSCN59~1, JPG
> vfat_add_entry: 1: DSCN5, 970(1), .J
> vfat_add_entry: 2: PG
> vfat_create: err 0
>
> Abnormal file:
> # cp -v DSCN5980.JPG /mnt/loop/
> `DSCN5980.JPG' -> `/mnt/loop/DSCN5980.JPG'
>
> dmesg:
> vfat_hashi: parent d1801e94, parent->d_op e0fbc620
> vfat_hashi: parent /, name DSCN5980.JPG
> vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
> vfat_cmpi: a dscn5980.jpg, b DSCN5980.JPG
> vfat_revalidate: name dscn5980.jpg, nd d65eaeec, flags 00000001
> vfat_lookup: name DSCN5980.JPG
> vfat_hashi: parent d1801e94, parent->d_op e0fbc620
> vfat_hashi: parent /, name DSCN5980.JPG
> vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
> vfat_cmpi: a DSCN5980.JPG, b DSCN5980.JPG
> vfat_revalidate: name DSCN5980.JPG, nd d65eaf24, flags 00000300
> vfat_lookup: name DSCN5980.JPG
> vfat_create: name DSCN5980.JPG
> vfat_add_entry: 0: DSCN5980, JPG
> vfat_create: err 0
>
> and:
> # ls -l /mnt/loop/
> totale 1363
> -rwxr-xr-x 1 root root 695514 22 nov 20:04 DSCN5970(1).JPG
> -rwxr-xr-x 1 root root 699770 22 nov 20:07 dscn5980.jpg
>
> dmesg:
> vfat_hashi: parent d1801e94, parent->d_op e0fbc620
> vfat_hashi: parent /, name DSCN5970(1).JPG
> vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
> vfat_cmpi: a DSCN5970(1).JPG, b DSCN5970(1).JPG
> vfat_revalidate: name DSCN5970(1).JPG, nd d2512eec, flags 00000000
> vfat_lookup: name DSCN5970(1).JPG
> vfat_hashi: parent d1801e94, parent->d_op e0fbc620
> vfat_hashi: parent /, name dscn5980.jpg
> vfat_cmpi: parent d1801e94, parent->d_op e0fbc620
> vfat_cmpi: a DSCN5980.JPG, b dscn5980.jpg
> vfat_revalidate: name DSCN5980.JPG, nd d2512eec, flags 00000000

This is different thing. Please try "shortname=winnt" or "shortname=mixed"
mount option for shortname (default is shortname=lower).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
