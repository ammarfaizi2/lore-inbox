Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272778AbRIGRDl>; Fri, 7 Sep 2001 13:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272781AbRIGRDb>; Fri, 7 Sep 2001 13:03:31 -0400
Received: from picard.auto.tuwien.ac.at ([128.130.12.4]:23779 "EHLO
	picard.auto.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S272778AbRIGRD2>; Fri, 7 Sep 2001 13:03:28 -0400
Date: Fri, 7 Sep 2001 19:03:43 +0200 (CEST)
From: Heinz Deinhart <heinz@auto.tuwien.ac.at>
To: Dan Hollis <goemon@anime.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: K7/Athlon optimizations and Sacrifices to the Great Ones.
In-Reply-To: <Pine.LNX.4.30.0109061330420.8699-100000@anime.net>
Message-ID: <Pine.LNX.4.33.0109071856530.6747-100000@xenon.auto.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Dan Hollis wrote:

> Anyone yet verified if burnMMX2 causes the same failures the
> athlon-optimized kernel does?

several versions of Robert's burnMMX2 run on by problematic athlons
without failing for several hours.

I did some trial and error modifications to mmx.c and found out
that this one makes my athlons happy (but must admin i have
no clue why). it seems to run stable now.

--- linux-2.4.9/arch/i386/lib/mmx.c	Tue May 22 19:23:16 2001
+++ linux-2.4.9-ac6-hack/arch/i386/lib/mmx.c	Sat Sep  8 00:51:33 2001
@@ -194,6 +194,9 @@
 		: : "r" (from), "r" (to) : "memory");
 		from+=64;
 		to+=64;
+	__asm__ __volatile__ (
+		"  sfence \n" : :
+	);
 	}
 	for(i=(4096-320)/64; i<4096/64; i++)
 	{

maybe someone with more knowledge can take a look..

ciao,
heinz

-- 
Heinz Deinhart <heinz@auto.tuwien.ac.at>
+43 1 58801-18321
Technische Universitaet Wien, Dept. E183/1

