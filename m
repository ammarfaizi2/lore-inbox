Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264738AbTE1QWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbTE1QWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:22:30 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:25609 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S264738AbTE1QW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:22:29 -0400
Date: Wed, 28 May 2003 18:35:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: mika.penttila@kolumbus.fi, <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@digeo.com>, <hugh@veritas.com>,
       <LW@karo-electronics.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <20030527.142233.71088632.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305281827290.5042-100000@serv>
References: <Pine.LNX.4.44.0305261414060.12110-100000@serv>
 <20030526.153415.41663121.davem@redhat.com> <Pine.LNX.4.44.0305270111370.5042-100000@serv>
 <20030527.142233.71088632.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 May 2003, David S. Miller wrote:

>    The point I don't like about update_mmu_cache() is that it's called 
>    _after_ set_pte(). Practically it's maybe not a problem right now, but 
>    the cache synchronization should happen before set_pte().
> 
> update_mmu_cache() is specifically supposed to always occur before
> anyone could try to use the mapping created.
> 
> If this is ever violated, it will be fixed because it is a BUG().

set_pte() establishes the mapping, this means another cpu can get the pte 
and start reading the data e.g. into the instruction cache, but if that 
cpu still has dirty data in the data cache (e.g. a write() or a disk 
read), the following update_mmu_cache() might be too late.

bye, Roman

