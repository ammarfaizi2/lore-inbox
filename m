Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWECFEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWECFEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWECFEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:04:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:17266 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965091AbWECFEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:04:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GF81rgGqHW0ajsTzDfkXMJEJKKRNK28TeVmAp8D3sccyKnZdZGwp/U0YgAdBZdal0q/x5XqKGqHFMpJwdruWazrz77gkzNbyDxU0Ofj4gnww4nI88IBluW7K3K49VoX/XaLQ/s9vYiBaUSvRRI4TKXUmiGNJ9eOklHClGoJoxPw=
Message-ID: <6934efce0605022204n233a6b04u4fafee8e07c0b594@mail.gmail.com>
Date: Tue, 2 May 2006 22:04:41 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Arnd Bergmann" <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <625fc13d0605021927l30ed3f86v48ad8fec9ec36051@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <200605030200.29141.arnd@arndb.de>
	 <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
	 <625fc13d0605021927l30ed3f86v48ad8fec9ec36051@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you explain a bit more?  If you aren't going to use the MTD, why
> rely on it at all?

I plan to could do 'mount -t axfs /dev/mtdblock2 /mnt/axfs' and use
the mtd to get the address to flash from map->cached or maybe
mtd->point.  Personally I think this is a clean approach to mounting
this fs.  Right now we do it like linear cramfs 'mount -t cramfs -o
physaddr=0xDEADBEEF /dev/null /mnt/axfs' and then map flash ourselves
with ioremap().  I'd like to enable a mode like this to in case you
don't have MTD.   But I prefer the former.

> Have you done comparisons vs. squashfs at all?  It does better at both
> performance and compression that cramfs, so I'm curious.

Haven't done any performance testing on squashfs.  I did see some
compression analysis that basically showed that squashfs did compress
better but paid for that flash saving in extra RAM.
