Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQL2B5v>; Thu, 28 Dec 2000 20:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130198AbQL2B5l>; Thu, 28 Dec 2000 20:57:41 -0500
Received: from jalon.able.es ([212.97.163.2]:15611 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130193AbQL2B5g>;
	Thu, 28 Dec 2000 20:57:36 -0500
Date: Fri, 29 Dec 2000 02:27:03 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CCFOUND and more
Message-ID: <20001229022703.A3038@werewolf.able.es>
In-Reply-To: <20001226211114.A1511@werewolf.able.es> <8203.977977379@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <8203.977977379@ocs3.ocs-net>; from kaos@ocs.com.au on Thu, Dec 28, 2000 at 05:22:59 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2000.12.28 Keith Owens wrote:
> 
> Yes.  Some arch files change CROSS_COMPILE after CC has been set and
> expect the change to flow into the definition of CC.  This "feature"
> only works because '=' stores the value as text and reevaluates the
> text each time, automatically picking up any changes to CROSS_COMPILE.
> Using CC := might break m68k and mips.  The makefile redesign for 2.5
> will fix this problem once and for all.
> 

OK, understrood. Anyway, I know there is not too much impact of this
issue, but you could always convert-to-fast-version the more
critical vars with something like:

CC = .........
CPP = $(CC) -E
..
include arch/$(ARCH)/Makefile

# Eval them once forever
CC:=$(CC)
CPP:=$(CPP)


-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3-aa3 #3 SMP Wed Dec 27 10:25:32 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
