Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWECIan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWECIan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 04:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWECIan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 04:30:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27074 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965120AbWECIam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 04:30:42 -0400
Subject: Re: [RFC] Advanced XIP File System
From: David Woodhouse <dwmw2@infradead.org>
To: Jared Hulbert <jaredeh@gmail.com>
Cc: Josh Boyer <jwboyer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6934efce0605022204n233a6b04u4fafee8e07c0b594@mail.gmail.com>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <200605030200.29141.arnd@arndb.de>
	 <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
	 <625fc13d0605021927l30ed3f86v48ad8fec9ec36051@mail.gmail.com>
	 <6934efce0605022204n233a6b04u4fafee8e07c0b594@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 03 May 2006 09:31:19 +0100
Message-Id: <1146645079.16449.35.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 22:04 -0700, Jared Hulbert wrote:
> I plan to could do 'mount -t axfs /dev/mtdblock2 /mnt/axfs' and use
> the mtd to get the address to flash from map->cached or maybe
> mtd->point.  Personally I think this is a clean approach to mounting
> this fs.  Right now we do it like linear cramfs 'mount -t cramfs -o
> physaddr=0xDEADBEEF /dev/null /mnt/axfs' and then map flash ourselves
> with ioremap().  I'd like to enable a mode like this to in case you
> don't have MTD.   But I prefer the former. 

It makes sense. If you're going to use MTD drivers for other partitions
of the flash, you want to be able to co-ordinate with it so you know
when the flash is being written to. You want to be able to use its
partitioning rather than hard-coding the physical address and length of
what might be a dynamic partition. You want the MTD driver to know that
the device in question is in use.

-- 
dwmw2

