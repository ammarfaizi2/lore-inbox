Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289802AbSAWLpr>; Wed, 23 Jan 2002 06:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289806AbSAWLph>; Wed, 23 Jan 2002 06:45:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289802AbSAWLpZ>;
	Wed, 23 Jan 2002 06:45:25 -0500
Date: Wed, 23 Jan 2002 03:44:11 -0800 (PST)
Message-Id: <20020123.034411.71089598.davem@redhat.com>
To: manfred@colorfullife.com, masp0008@stud.uni-saarland.de
Cc: drobbins@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Studierende der Universitaet des Saarlandes <masp0008@stud.uni-saarland.de>
   Date: Wed, 23 Jan 2002 10:38:09 +0000

   Then "nopentium" only works by chance: I assume that speculative
   operations do not walk the page tables, thus the probability that a
   valid TLB entry is found for the GART mapped page is slim. But if there
   is an entry, then the corruption would still occur.

This isn't true.  The speculative store won't get data into the
cache if there is a TLB miss.

4MB pages map the GART pages and "other stuff", ie. memory used by
other subsystems, user pages and whatever else.  This is the only
way the bug can be thus triggered for kernel mappings, which is why
turning off 4MB pages fixes this part.

The only unresolved bit is the fact that we map these GART pages
cacheable into user space.  That ought to cause the problem too.
