Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVL1R5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVL1R5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVL1R5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:57:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:21466 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964858AbVL1R5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:57:19 -0500
Message-ID: <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 28 Dec 2005 18:57:15 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200512281054.26703.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_16)
Organization: SuSE Linux AG
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua> <200512281054.26703.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi 28.12.2005 09:54 schrieb Denis Vlasenko <vda@ilport.com.ua>:

> > # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
> > size-131072 0 0 131072
> > size-65536 0 0 65536
> > size-32768 1 1 32768
> > size-16384 0 0 16384
> > size-8192 253 253 8192
> > size-4096 89 89 4096
> > size-2048 248 248 2048
> > size-1024 312 312 1024
> > size-512 545 648 512
> > size-256 213 270 256
> > size-128 5642 5642 128
> > size-64 1025 1586 64
> > size-32 2262 7854 32
>
> Wow... I overlooked that you are requesting data from x86_64 boxes.
> Mine is not, it's i386...

This whole discussion is pointless anyways because most kmallocs are
constant
sized and with a constant sized kmalloc the slab is selected at compile
time.

What would be more interesting would be to redo the complete kmalloc
slab list.

I remember the original slab paper from Bonwick actually mentioned that
power of
two slabs are the worst choice for a malloc - but for some reason Linux
chose them
anyways. That would require a lot of measurements in different workloads
on the
actual kmalloc sizes and then select a good list, but could ultimately
safe
a lot of memory (ok not that much anymore because the memory intensive
allocations should all have their own caches, but at least some)

Most likely the best list is different for 32bit and 64bit too.

Note that just looking at slabinfo is not enough for this - you need the
original
sizes as passed to kmalloc, not the rounded values reported there.
Should be probably not too hard to hack a simple monitoring script up
for that
in systemtap to generate the data.

-Andi


