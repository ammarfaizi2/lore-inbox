Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285965AbRLTDbd>; Wed, 19 Dec 2001 22:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285972AbRLTDbX>; Wed, 19 Dec 2001 22:31:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27660 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285965AbRLTDbD>; Wed, 19 Dec 2001 22:31:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: 19 Dec 2001 19:30:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vrm1f$mde$1@cesium.transmeta.com>
In-Reply-To: <m14rmnw6p3.fsf@frodo.biederman.org> <Pine.GSO.4.21.0112191153280.11104-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0112191153280.11104-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> On 19 Dec 2001, Eric W. Biederman wrote:
> 
> > I have alarm bells ringing in my gut saying there are pieces of your
> > proposal that are on the edge of being overly complex... But without
> > source I can't really say.  Arbitrary NULL padding between images is
> > cool but why?
> 
> 	Alignment that might be wanted by loaders.  Take that with hpa - for
> all I care it's a non-issue.  while(!*p) p++; added before p = handle_part(p);
> in the main loop...
> 

Examples on allowing NULL padding makes life easier for the
bootloader, because it can pick its own alignment:

a) A bootloader uses INT 15h AH=87h to move things to high memory.
   This function can only move 16-bit words.

b) SYSLINUX' builting high bcopy routine can only move 32-bit words.

c) If a boot loader runs in protected mode, it may want to operate on
   4K pages only.

d) A block-oriented boot loader like LILO can simply concatentate the
   blocks of multiple files together (as long as it can make sure
   the slop is zeroed out.)

It's an insignificant addition to the kernel that allows the
bootloader to be potentially significantly simpler, by removing the
corner cases.  This is a Good Thing[TM].

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
