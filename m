Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288984AbSAFQ3Z>; Sun, 6 Jan 2002 11:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAFQ3P>; Sun, 6 Jan 2002 11:29:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288984AbSAFQ26>; Sun, 6 Jan 2002 11:28:58 -0500
Subject: Re: [PATCH] C undefined behavior fix
To: dewar@gnat.com
Date: Sun, 6 Jan 2002 16:39:21 +0000 (GMT)
Cc: guerby@acm.org, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, trini@kernel.crashing.org, velco@fadata.bg
In-Reply-To: <20020106162213.37901F28C5@nile.gnat.com> from "dewar@gnat.com" at Jan 06, 2002 11:22:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NGKQ-0005ky-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it  is the compiler burden to prove that the extra stuff
> "read" is not observable (in the sense of external
> effect) at execution. In a memory-mapped I/O architecture
> where there is a distinction on external effects between a byte read
> and a word read (eg: a crash :),  the compiler can't get very far IMHO
> (if it accepts the declaration of course).

In the Linux case mmio isn't a problem. The rules for mmio in the portable
code require you use architecture dependant macros (readb etc) and that
the mmio space is mapped via ioremap.

Our ioremap/mmio stuff does a whole variety of things on different platforms
including simple memory accesses, adding I/O fences, motherboard specific
function calls, and tlb bypass.

That side of things is all nicely and cleanly handled.
