Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTE3AiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 20:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTE3AiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 20:38:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:3624 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263187AbTE3AiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 20:38:10 -0400
Date: Thu, 29 May 2003 17:51:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bonganilinux@mweb.co.za, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.5.70-mm1 Strangeness
Message-Id: <20030529175135.7b204aaf.akpm@digeo.com>
In-Reply-To: <20030529.171114.34756018.davem@redhat.com>
References: <20030529221622.542a6df5.bonganilinux@mweb.co.za>
	<20030529135541.7c926896.akpm@digeo.com>
	<20030529.171114.34756018.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 00:51:28.0717 (UTC) FILETIME=[9ABCCFD0:01C32645]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Thu, 29 May 2003 13:55:41 -0700
> 
>    The ip_dst_cache seems unreasonably large.  Unless your desktop is a
>    backbone router or something.
> 
> Lots of DST entries can result on any machine actually.  We create one
> per source address, not just per destination address.  So if you talk
> to a lot of sites, or lots of sites talk to you, you'll get a lot of
> DST entries.
> 
> Regardless, 80MB _IS_ excessive.  That's nearly 400,000 entries.
> It definitely indicates there is a leak somewhere.
> 
> Although it say:
> 
> ip_dst_cache       19470  19470   4096    1    1
> 
> Which is 19470 active objects right?

Yes, 19470 entries.  But note that each entry is 4096 bytes.

Something seems to have gone and bumped the object size from 240 bytes up
to 4096.  This is actually what I want CONFIG_DEBUG_PAGEALLOC to do, but I
don't think it does it yet.  

Bongani, if you have CONFIG_DEBUG_PAGEALLOC enabled then please try turning
it off.  And maybe Manfred can throw some light on what slab has done
there.

