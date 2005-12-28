Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVL1VFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVL1VFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVL1VFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:05:39 -0500
Received: from waste.org ([64.81.244.121]:24707 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964911AbVL1VFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:05:38 -0500
Date: Wed, 28 Dec 2005 15:01:25 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andreas Kleen <ak@suse.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051228210124.GB1639@waste.org>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua> <200512281054.26703.vda@ilport.com.ua> <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 06:57:15PM +0100, Andreas Kleen wrote:
> Am Mi 28.12.2005 09:54 schrieb Denis Vlasenko <vda@ilport.com.ua>:
> 
> > > # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
> > > size-131072 0 0 131072
> > > size-65536 0 0 65536
> > > size-32768 1 1 32768
> > > size-16384 0 0 16384
> > > size-8192 253 253 8192
> > > size-4096 89 89 4096
> > > size-2048 248 248 2048
> > > size-1024 312 312 1024
> > > size-512 545 648 512
> > > size-256 213 270 256
> > > size-128 5642 5642 128
> > > size-64 1025 1586 64
> > > size-32 2262 7854 32
> >
> > Wow... I overlooked that you are requesting data from x86_64 boxes.
> > Mine is not, it's i386...
> 
> This whole discussion is pointless anyways because most kmallocs are
> constant
> sized and with a constant sized kmalloc the slab is selected at compile
> time.
> 
> What would be more interesting would be to redo the complete kmalloc
> slab list.
> 
> I remember the original slab paper from Bonwick actually mentioned that
> power of
> two slabs are the worst choice for a malloc - but for some reason Linux
> chose them
> anyways. That would require a lot of measurements in different workloads
> on the
> actual kmalloc sizes and then select a good list, but could ultimately
> safe
> a lot of memory (ok not that much anymore because the memory intensive
> allocations should all have their own caches, but at least some)
> 
> Most likely the best list is different for 32bit and 64bit too.
> 
> Note that just looking at slabinfo is not enough for this - you need the
> original
> sizes as passed to kmalloc, not the rounded values reported there.
> Should be probably not too hard to hack a simple monitoring script up
> for that
> in systemtap to generate the data.

Something like this:

http://lwn.net/Articles/124374/

-- 
Mathematics is the supreme nostalgia of our time.
