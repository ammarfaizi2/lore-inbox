Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTFGRVc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFGRVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:21:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263293AbTFGRVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:21:31 -0400
Date: Sat, 7 Jun 2003 10:34:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stewart Smith <stewart@linux.org.au>
cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [EVIL-PATCH] getting rid of lib/lib.a and breaking many archs
 in the processes (was Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved
 symbols)
In-Reply-To: <20030607073321.GC1540@cancer>
Message-ID: <Pine.LNX.4.44.0306071028510.2956-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jun 2003, Stewart Smith wrote:
> 
> This patch needs a couple of extra things before it drops it's evil
> status, and I'm not sure how to do them exactly.

How about making the lib/ directory separate out the "these are optional"  
pieces from the "these are basic libs that got explicitly enabled by the
user", and leave the archive usage for the truly optional stuff?

There's nothing inherently wrong with using the archive format per se, and
it still makes sense to just let the linker do the simple stuff instead of
adding unnecessary code to the configuration management to do stuff that
the linker would give us for free.

The _clean_ way to do this (I think) might be to make the normal build 
rules understand a "obj-l" for "library objects", and always build a 
"lib.a" for those, instead of having the magic "if there is a L_TARGET, 
use obj-y and make a library of them" special case rule.

Sam, can you try to sprinkle the proper Makefile magic pixie-dust around?


		Linus


