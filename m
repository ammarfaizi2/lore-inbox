Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbSJEDSy>; Fri, 4 Oct 2002 23:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261991AbSJEDSy>; Fri, 4 Oct 2002 23:18:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1553 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261975AbSJEDSx>; Fri, 4 Oct 2002 23:18:53 -0400
Date: Fri, 4 Oct 2002 20:26:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.GSO.4.21.0210042314130.21637-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210042024080.1257-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Alexander Viro wrote:
> 
> It's getting better.  The thing _does_ survive if there is no cacheline
> boundary between the calls of pci_write_config_dword(); otherwise it
> dies on that boundary.

Ok, that definitely clinches it - it's the cache miss coupled with host
bridge confusion that causes it to start fetching from PCI space instead
of RAM (or, more likely just get really confused about it and maybe 
fetch from both).

It's always good to understand why someting doesn't work, rather than just
revert it because it breaks inexplicably.

		Linus

