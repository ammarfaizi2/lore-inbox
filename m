Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSH1NoZ>; Wed, 28 Aug 2002 09:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSH1NoZ>; Wed, 28 Aug 2002 09:44:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6162 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318835AbSH1NoY>; Wed, 28 Aug 2002 09:44:24 -0400
Date: Wed, 28 Aug 2002 10:48:22 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] limit buffer_head consumption to 10% of ZONE_NORMAL
In-Reply-To: <3D6C54FF.E3A49037@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208281047190.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Andrew Morton wrote:

> This patch addresses the excessive consumption of ZONE_NORMAL by
> buffer_heads on highmem machines.
>
> The buffer.c change implements the buffer_head accounting - it sets the
> upper limit on buffer_head memory occupancy to 10% of ZONE_NORMAL.
>
> A possible side-effect of this change is that the kernel will perform
> more calls to get_block() to map pages to disk.  This will only be
> observed when a file is being repeatadly overwritten - this is the only
> case in which the "cached get_block result" in the buffers is useful.

Another possible side effect is writing dirty data to disk
earlier when we've got insane amounts.

All in all, this patch should make the system behave much
more sanely. I like it.

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

