Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSIATWQ>; Sun, 1 Sep 2002 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSIATWQ>; Sun, 1 Sep 2002 15:22:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54539 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317365AbSIATWP>; Sun, 1 Sep 2002 15:22:15 -0400
Date: Sun, 1 Sep 2002 12:34:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.33-bk testing
In-Reply-To: <200209011916.VAA18956@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0209011231500.2126-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Sep 2002, Mikael Pettersson wrote:
> 
> In kernels 2.5.13--2.5.32, it was always the case that with my hack,
> a mounted ext2 would seem to work for a while and then break down,
> e.g. when unmounted and fsck:d. I haven't checked 2.5.33.

Ok, that seems to clinch it - that definitely means that the floppy driver 
is confused by non-512-byte buffers. And that in turn is almost certainly 
due to some subtle bug in the bio rework.

The only bug I really fixed in 2.5.33 was completely unrelated, and had to
do with the setup for the block open() routine not setting up the request
queue - which caused problems for the media change logic. 

		Linus

