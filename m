Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSHKAvf>; Sat, 10 Aug 2002 20:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSHKAvf>; Sat, 10 Aug 2002 20:51:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44814 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317392AbSHKAvf>; Sat, 10 Aug 2002 20:51:35 -0400
Date: Sat, 10 Aug 2002 17:56:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <3D55B109.CA52DB9C@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208101755060.1391-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Andrew Morton wrote:
> 
> If not, I don't think it's worth making this change just for
> the highmem read/write thing (calculating `current' at each
> spin_lock site...)   I just open coded it.

Well, this way it will now do the preempt count twice (once in 
kmap_atomic, once in th eopen-coded one) if preempt is enabled.

I'd suggest just making k[un]map_atomic() always do the
inc/dec_preempt_count. Other ideas?

		Linus

