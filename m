Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSHNINX>; Wed, 14 Aug 2002 04:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHNINW>; Wed, 14 Aug 2002 04:13:22 -0400
Received: from c-180-196-193.ka.dial.de.ignite.net ([62.180.196.193]:911 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S315282AbSHNINV>; Wed, 14 Aug 2002 04:13:21 -0400
Date: Wed, 14 Aug 2002 10:16:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Imran Badr <imran.badr@cavium.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Cache coherency and snooping
Message-ID: <20020814101654.B14197@linux-mips.org>
References: <20020814022958.B11645@linux-mips.org> <0aa401c2432e$04a95cc0$9e10a8c0@IMRANPC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0aa401c2432e$04a95cc0$9e10a8c0@IMRANPC>; from imran.badr@cavium.com on Tue, Aug 13, 2002 at 06:00:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 06:00:43PM -0700, Imran Badr wrote:

> Please advise if following sequence of operations are going to help:
> 
> alloc memory
> reserve the page
> flush every cache

That's an extremly expensive operation on some platforms and there's no
portable kernel API to do it.

Note that the flush_cache_*() functions are not suitable for I/O as you
want to do it.  Many platforms such as i386 implement these functions
as empty functions.

> call ioremap_nocache

You said you intend to remap memory, that is RAM.  The ioremap*() functions
will refuse to remap RAM; they're only suitable for other types of memory
such as PCI boards.  If the latter was your intension then ioremap_nocache()
will work as intended.

Again, unless your hardware is fucked beyond recognition it'll do a better
job at keeping cache coherence than software.

  Ralf
