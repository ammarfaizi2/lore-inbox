Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWBJNFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWBJNFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWBJNFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:05:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:11972 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932068AbWBJNFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:05:23 -0500
Date: Fri, 10 Feb 2006 14:02:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup possibility in asm-i386/string.h
In-Reply-To: <200602100123.36077.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602101355490.30994@scrub.home>
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071336060.30994@scrub.home>
 <20060210000523.GE3524@stusta.de> <200602100123.36077.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Feb 2006, Andi Kleen wrote:

> > I remember playing with using more gcc builtins in the kernel some time 
> > ago, and some gcc builtin used a different library function, which was a 
> > function the kernel did not supply.
> 
> It works fine on x86-64. If something is missing it can be also supplied.

I think I now see what the real problem was, x86-64 does:

#define strcpy __builtin_strcpy

which also renames the version in lib/string.c, so x86-64 never had a 
fallback copy for __builtin_sprintf.
Can we please get rid of -freestanding and fix x86-64 instead?

bye, Roman
