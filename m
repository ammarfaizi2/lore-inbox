Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbSJLLuw>; Sat, 12 Oct 2002 07:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262907AbSJLLuw>; Sat, 12 Oct 2002 07:50:52 -0400
Received: from dp.samba.org ([66.70.73.150]:7620 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262906AbSJLLuw>;
	Sat, 12 Oct 2002 07:50:52 -0400
Date: Sat, 12 Oct 2002 21:52:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Steven French <sfrench@us.ibm.com>
Cc: Reuben Farrelly <reuben-linux@reub.net>, linux-kernel@vger.kernel.org
Subject: Re: "duplicate const" compile warning in 2.5.42
Message-ID: <20021012115257.GA15387@krispykreme>
References: <OF38E5DBB6.1DFD70C1-ON87256C50.002E73F2@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF38E5DBB6.1DFD70C1-ON87256C50.002E73F2@boulder.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Reuben,
> The "duplicate const" compile warning you mention seems to be a minor
> problem with the min/max macros.
> 
> The fix for the 64 bit warnings for the cifs vfs are not going to affect
> the duplicate const minor warning caused by the min/max macro.  This
> warning does not show up on my i386 2.5.41 builds.

Im using gcc 3.2 for ppc64 compiles, I guess earlier compilers dont
emit this warning.

Its not Steve's fault, for example mm/vmscan.c:shrink_caches gets
a warning because of

const int nr_pages:
...
to_reclaim = max(to_reclaim, nr_pages);

ie:

to_reclaim = ({
	const typeof(to_reclaim) _x = (to_reclaim);
	const typeof(nr_pages) _y = (nr_pages);
	(void) (&_x == &_y);
	_x > _y ? _x : _y;
});

Which ends up as const const int _y = (nr_pages);

Anton
