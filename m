Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262957AbREWCoB>; Tue, 22 May 2001 22:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbREWCnv>; Tue, 22 May 2001 22:43:51 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32774 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262957AbREWCnn>; Tue, 22 May 2001 22:43:43 -0400
Date: Tue, 22 May 2001 19:43:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: jgarzik@mandrakesoft.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105230020.CAA79506.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.21.0105221940170.4713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 May 2001 Andries.Brouwer@cwi.nl wrote:
>
> > why not implement partitions as simply doing block remaps
> 
> Everybody agrees.

No they don't.

Look at the cost of lvm. Function calls, buffer head remapping, the
works. You _need_ that for a generic LVM layer, but you sure as hell don't
need it for simple partitioning.

Can LVM do it? Sure.

Do we need LVM to do it? No.

Does LVM simplify anything? No.

It doesn't get much simpler than a single line that does the
equivalent of "bh->sector += offset". Most of the bulk of the code in the
partitioning stuff is for actually parsing the partitions, and we need
that to bootstrap. Maybe we can get rid of some of the more esoteric ones
(ie pretty much everything except for the native partitioning code for
each architecture) and tell people to use LVM for the rest.

In short, there are _no_ advantages to involve LVM here.

		Linus

