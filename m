Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315115AbSEHU0V>; Wed, 8 May 2002 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSEHU0U>; Wed, 8 May 2002 16:26:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54034 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315115AbSEHU0U>; Wed, 8 May 2002 16:26:20 -0400
Subject: Re: [PATCH] IDE 58
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 8 May 2002 21:44:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        dalecki@evision-ventures.com (Martin Dalecki),
        andre@linux-ide.org (Andre Hedrick),
        bjorn.wesen@axis.com (Bjorn Wesen), paulus@samba.org (Paul Mackerras),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020508194931.25660@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at May 08, 2002 09:49:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175YI5-0002LD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I though about that, but what about corner cases where only a single
> register can be accessed ? (typically alt status). Provide specific
> routines ? Also, how does the extended addressing works ? by writing
> several times to the cyl registers ? That would have to be dealt with
> as well in each host driver then.

There are lots of cases we don't care about speed - things like setup of
the controller, changing UDMA mode etc. 

> Right. We could go the darwin (apple) way and have taskfile_load/store
> functions doing the entire registers controlled by a bitmask of which
> registers has to be touched. it has a cost (testing each bit and
> conditionally branching, which can suck hard) but probably less than

Get yourself a conditional move instruction 8)

> an indirect function call which isn't predictable.

Or you have a small set of such functions for the critical paths - ie doing
actual block I/O which pass the set of values required to do that operation
and do the stores. What are the performance critical paths

	Begin a disk write
	Begin a disk read
	PIO transfer in
	PIO transfer out
	End a disk I/O fastpaths (no error case)

	Maybe ATAPI command writes ?

beyond that I doubt the rest are critical 

Alan
