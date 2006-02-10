Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWBJNxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWBJNxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWBJNxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:53:11 -0500
Received: from ns2.suse.de ([195.135.220.15]:15488 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbWBJNxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:53:09 -0500
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Cleanup possibility in asm-i386/string.h
Date: Fri, 10 Feb 2006 14:49:05 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <200602071215.46885.ak@suse.de> <200602100123.36077.ak@suse.de> <Pine.LNX.4.61.0602101355490.30994@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0602101355490.30994@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101449.07491.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 14:02, Roman Zippel wrote:
> Hi,
> 
> On Fri, 10 Feb 2006, Andi Kleen wrote:
> 
> > > I remember playing with using more gcc builtins in the kernel some time 
> > > ago, and some gcc builtin used a different library function, which was a 
> > > function the kernel did not supply.
> > 
> > It works fine on x86-64. If something is missing it can be also supplied.
> 
> I think I now see what the real problem was, x86-64 does:
> 
> #define strcpy __builtin_strcpy
> 
> which also renames the version in lib/string.c, so x86-64 never had a 
> fallback copy for __builtin_sprintf.
> Can we please get rid of -freestanding and fix x86-64 instead?

Ok I can fix that. Just removing the defines should be ok i guess 
(afaik gcc detects them automatically as the builtin) 

I don't know if the freestanding in the main Makefile isn't needed 
for other architectures so I won't touch it right now.

-Andi
