Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTIAQeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTIAQeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:34:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59273 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263021AbTIAQeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:34:02 -0400
Date: Mon, 1 Sep 2003 17:33:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901163354.GA3556@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030901054413.GF748@mail.jlokier.co.uk> <20030901144304.GA1327@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901144304.GA1327@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> I'm a little concerned I have the wrong test, why would a 2.1Ghz Athlon 
> say it is too slow?

It's the right test.  "too slow" means that where shared memory is
mapped at a certain separation, alternating accesses between the
different virtual addresses are much slower (10-20 times) than if the
underlying mapped memory is not shared.

All Athlons show this slowdown for any virtual address separation
which is not a multiple of 32k.  No Intels do, with the possible
exception of a P4 which showed inconsistent results and needs further
investigation.

Your freebsds don't what CPU they are, but let me guess..

     freebsd isn't an AMD
     freebsd3 and freebsd4 are both AMD K6, and freebsd3 is the faster

-- Jamie

> ==== freebsd ====
> (512) [32,32,1] Test separation: 4096 bytes: pass
...
> FreeBSD freebsd.bitmover.com 2.2.8-RELEASE FreeBSD 2.2.8-RELEASE #0: Mon Nov 30 06:34:08 GMT 1998     jkh@time.cdrom.com:/usr/src/sys/compile/GENERIC  i386

> ==== freebsd3 ====
> (64) [33,3,1] Test separation: 4096 bytes: FAIL - too slow
> (64) [33,3,1] Test separation: 8192 bytes: FAIL - too slow
> (512) [19,26,1] Test separation: 16384 bytes: pass
> VM page alias coherency test: minimum fast spacing: 16384 (4 pages)
> 
> FreeBSD freebsd3.bitmover.com 3.2-RELEASE FreeBSD 3.2-RELEASE #0: Fri Jun  2 11:34:52 PDT 2000     root@freebsd3.bitmover.com:/usr/src/sys/compile/DAVICOM  i386
> 
> ==== freebsd4 ====
> (256) [92,26,5] Test separation: 4096 bytes: FAIL - too slow
> (256) [92,26,5] Test separation: 8192 bytes: FAIL - too slow
> (1024) [75,101,5] Test separation: 16384 bytes: pass
> VM page alias coherency test: minimum fast spacing: 16384 (4 pages)
> 
> FreeBSD freebsd4.bitmover.com 4.1-RELEASE FreeBSD 4.1-RELEASE #0: Fri Jul 28 14:30:31 GMT 2000     jkh@ref4.freebsd.org:/usr/src/sys/compile/GENERIC  i386
