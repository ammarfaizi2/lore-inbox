Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288932AbSATTPt>; Sun, 20 Jan 2002 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288948AbSATTPj>; Sun, 20 Jan 2002 14:15:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44810 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288932AbSATTPd>; Sun, 20 Jan 2002 14:15:33 -0500
Date: Sun, 20 Jan 2002 20:16:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Justin Cormack <kernel@street-vision.com>, linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
Message-ID: <20020120201603.L21279@athlon.random>
In-Reply-To: <200201181743.g0IHhO226012@street-vision.com> <3C48607C.35D3DDFF@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C48607C.35D3DDFF@redhat.com>; from arjanv@redhat.com on Fri, Jan 18, 2002 at 05:50:53PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 05:50:53PM +0000, Arjan van de Ven wrote:
> Justin Cormack wrote:
> > 
> > Reading files with O_DIRECT works very nicely for me off a single drive
> > (for video streaming, so I dont want cacheing), but is extremely slow on
> > software raid0 devices, and striped lvm volumes. Basically a striped
> > raid device reads at much the same speed as a single device with O_DIRECT,
> > while reading the same file without O_DIRECT gives the expected performance
> > (but with unwanted cacheing).
> > 
> > raw devices behave similarly (though if you are using them you can probably
> > do your own raid0).
> > 
> > My guess is this is because of the md blocksizes being 1024, rather than
> > 4096: is this the case and is there a fix (my quick hack at md.c to try
> > to make this happen didnt work).
> 
> well not exactly. Raid0 is faster due to readahead (eg you read one
> block and the kernel 
> sets the OTHER disk also working in parallel in anticipation of you
> using that). O_DIRECT
> is of course directly in conflict with this as you tell the kernel that
> you DON'T want
> any optimisations....

if you read in chunks of a few mbytes per read syscall, the lack of
readahead shouldn't make much difference (this is true for both raid and
standalone device). If there's a relevant difference it's more liekly an
issue with the blocksize.

Andrea
