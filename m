Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129405AbQKNPv0>; Tue, 14 Nov 2000 10:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbQKNPvP>; Tue, 14 Nov 2000 10:51:15 -0500
Received: from [208.171.173.186] ([208.171.173.186]:1552 "EHLO
	challenge.atlanticweb.com") by vger.kernel.org with ESMTP
	id <S129405AbQKNPu7>; Tue, 14 Nov 2000 10:50:59 -0500
From: "Chris Swiedler" <ceswiedler_lk@mindspring.com>
To: "Szabolcs Szakacsits" <szaka@f-secure.com>, <linux-kernel@vger.kernel.org>
Cc: "Erik Mouw" <J.A.K.Mouw@ITS.TUDelft.NL>
Subject: RE: [PATCH] Re: reliability of linux-vm subsystem
Date: Tue, 14 Nov 2000 10:24:21 -0500
Message-ID: <NDBBIAJKLMMHOGKNMGFNGEJECPAA.ceswiedler_lk@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <Pine.LNX.4.30.0011132116420.20626-100000@fs129-190.f-secure.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Good, so the OOM killer works.
>
> But it doesn't work for this kind of application misbehaviours (or
> user attacks):
>
> main() { while(1) if (fork()) malloc(1); }

This seems to be a fork() bomb, not a VM issue. The system is overwhelmed by
the the forks, not by the space consumed by the allocations themselves. For
one thing, I've found that

main() { while(1) malloc(1024*1024); }

does not kill your system very quickly (if at all). Without actually writing
to the memory, it doesn't seem to be "really" allocated. Adding a memset()
will kill your system much more quickly.

chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
