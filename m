Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUANMB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUANMB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:01:29 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:42977 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266187AbUANMB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:01:27 -0500
Date: Wed, 14 Jan 2004 13:01:25 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
In-Reply-To: <20040113172751.GN9677@fs.tum.de>
Message-ID: <Pine.LNX.4.55.0401141230400.1436@jurand.ds.pg.gda.pl>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org>
 <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl> <20040113172751.GN9677@fs.tum.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Adrian Bunk wrote:

> Does -mabi=64 really work on any DECstation?
> 
> AFAIK none of the R2000, R3x00 and the R4x00 do support the 64bit ABI.

 Well, the R4000 and the R4400 implement the MIPS3 ISA (the R4000 was
actually first to implement it) and are thus obviously 64-bit processors.  
And I'm actually using a 64-bit kernel on my R4k DECstations routinely --
currently I'm torturing it on my 5000/260 with gcc 3.4 bootstraps and it
seems quite happy -- it appears rock-solid.

 The problem is the official kernel would work fine for a 64-bit
DECstation if it had an R4400 rev.2.0 or later.  I haven't heard of any
having such a processor -- the ones I have and the others reported by
poeple have either an R4000 rev.3.0 or an R4400 rev.1.0.  These processors
have errata that lead to erroneous behavior in a few common 64-bit
operations (according to the errata sheet, the R4000 actually has a
serious 32-bit erratum as well, but I haven't been able to trigger it
yet).  I have implemented appropriate workarounds (available upon
request), but they require changes not only to Linux, but to gcc and gas
as well.  I'm preparing to merge the changes to the tools -- hence my
current gcc 3.4 effort -- but until then the 64-bit port has to be marked
as experimental (marking R4000 and R4400 processor selections as such for
64-bit operation would be more accurate, but currently we don't have a
separate setting for them).

 See also arch/mips/dec/prom/call_o32.S for the only chunk of explicit
support code for 64-bit operation for the DECstation -- everything else
just works as is (modulo possible protability bugs in drivers).

 Going back to the subject -- what's the problem with dependencies?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
