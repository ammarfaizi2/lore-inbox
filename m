Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTEIR7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTEIR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:59:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37898 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263376AbTEIR7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:59:10 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hammer: MAP_32BIT
Date: 9 May 2003 11:11:15 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9gr03$42n$1@cesium.transmeta.com>
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030509113845.GA4586@averell>
By author:    Andi Kleen <ak@muc.de>
In newsgroup: linux.dev.kernel
>
> 
> On Fri, May 09, 2003 at 01:28:11PM +0200, mikpe@csd.uu.se wrote:
> > I have a potential use for mmap()ing in the low 4GB on x86_64.
> 
> Just use MAP_32BIT
> 
> > Sounds like your MAP_32BIT really is MAP_31BIT :-( which is too limiting.
> > What about a more generic way of indicating which parts of the address
> > space one wants? The simplest that would work for me is a single byte
> > 'nrbits' specifying the target address space as [0 .. 2^nrbits-1].
> > This could be specified on a per-mmap() basis or as a settable process attribute.
> 
> On x86-64 an mmap extension for that would be fine, but on i386 you get
> problems because mmap64() already maxes out the argument limit and you 
> cannot add more.
>  

How about this: since the address argument is basically unused anyway
unless MAP_FIXED is set, how about a MAP_MAXADDR which interprets the
address argument as the highest permissible address (or lowest
nonpermissible address)?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
