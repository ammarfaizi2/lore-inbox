Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSGTXRl>; Sat, 20 Jul 2002 19:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGTXRl>; Sat, 20 Jul 2002 19:17:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42226 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317592AbSGTXRl>; Sat, 20 Jul 2002 19:17:41 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027196403.1086.751.camel@sinai>
References: <1027196403.1086.751.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 01:32:36 +0100
Message-Id: <1027211556.17234.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wapless strict overcommit. The total address space
> +		commit for the system is not permitted to exceed 95% of
> +		free memory. This mode utilizes the new stricter accounting

Robert. If you are going to submit changes based on my code please
understand the code first. Your changes are bogus. Think about PTE table
overhead. Go do some simulation runs on a 2Gb box running Oracle.

The original code implements modes where the overcommit rules are

0. Heuristic

1. Never refuse

2. Never overcommit above swap for anonymous pages

3. Overcommit on the basis the kernel will never use > 50% of RAM

Your 95% mode is pure crap. I tried various values and I can assure you
that your code will fail dismally to do anything useful unless you are
below 65% when running Oracle for example.

I took the time to *measure* this stuff and test it in real world
setups. Please don't randomly frob with it unless you are going to
repeat the oracle test sets. 

Linus can you either drop this patch out or take the original version.
These changes will simply confuse people into thinking they have the
feature when they do not.



