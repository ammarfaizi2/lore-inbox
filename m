Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTARIof>; Sat, 18 Jan 2003 03:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTARIof>; Sat, 18 Jan 2003 03:44:35 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:1229 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S263313AbTARIod>;
	Sat, 18 Jan 2003 03:44:33 -0500
Date: Sat, 18 Jan 2003 08:53:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Bug? Sparc linux defines MAP_LOCKED == MAP_GROWSDOWN
Message-ID: <20030118085331.GB19390@bjl1.asuk.net>
References: <20030118032940.GB18282@bjl1.asuk.net> <20030118.001218.52982745.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118.001218.52982745.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Jamie Lokier <jamie@shareable.org>
>    Date: Sat, 18 Jan 2003 03:29:40 +0000
> 
>    On Sparc and Sparc64, MAP_LOCKED and MAP_GROWSDOWN are both defined
>    as 0x100.  This is a bug, isn't it?
>    
> Unfortunately it's one we're going to have to live with somehow.
> Probably by just saying MAP_GROWSDOWN is totally unsupported.
> I see no real use for it anyways.

I've never seen the point of it either - MAP_GROWSDOWN just allows the
stack to grow until it overwrites the next vma down, as far as I can
tell.  No guard page or anything.

I think MAP_GROWSDOWN should simply be deleted on all architectures
(some don't support it even though they define the flag anyway).

However if that doesn't happen, isn't it best if MAP_LOCKED on the
Sparc _doesn't_ imply MAP_GROWSDOWN?  That could lead to some peculiar
failure modes, if a program pokes an unmapped address (which a few do
for one reason or another) and happens to have a MAP_LOCKED region
above it.

I.e. I suggest renumbering MAP_GROWSDOWN in <asm-sparc{,64}/mman.h>.
Nobody in userspace will be using that, whereas there probably are a
few programs using MAP_LOCKED, and getting MAP_GROWSDOWN behaviour as
a bonus is a genuine bug.

cheers,
-- Jamie
