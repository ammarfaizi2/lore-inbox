Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTIAF6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTIAF6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:58:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:35721 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262600AbTIAF6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:58:11 -0400
Date: Mon, 1 Sep 2003 06:58:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901055804.GG748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <Pine.GSO.4.21.0308291820540.3919-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308291820540.3919-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> Are you also interested in m68k? ;-)
> 
> cassandra:/tmp# time ./test
> Test separation: 4096 bytes: FAIL - store buffer not coherent

Especially!  I hadn't expected to see any machine that would print
"store buffer not coherent".  It means that if there's an L1 cache, it
is coherent, but any store-then-load bypass in the CPU pipeline is
using the virtual address with no rollback after MMU translation.

I had thought it would only be the case with chips using an external
MMU, but now that I think about it, the older simpler chips aren't
going to bother with things like pipeline rollback wherever they can
get away without it!

(The other CPU that is reporting "store buffer not coherent" is
PA-RISC, which is even more of an eye opener.  That has a big 1MiB
coherent L1 cache, and the pipeline bypass is coherent for very large
separations but not others!)

Thanks,
-- Jamie
