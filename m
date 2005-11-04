Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKDRoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKDRoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKDRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:44:20 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:61025 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1750764AbVKDRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:44:19 -0500
To: mingo@elte.hu, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, andy@thermo.lanl.gov, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, pj@sgi.com
In-Reply-To: <Pine.LNX.4.64.0511040900160.27915@g5.osdl.org>
Message-Id: <20051104174356.B1B851846C2@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 10:43:56 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Linus,

Please stop focussing on mips as the bad boy. Mips is dead. It
has been for years and everyone knows it unless they are embedded. 
I wrote several times that I had tested other arches and every 
time you deleted those comments.  Not to mention that in the few
anecdotal (read no records were kept) tests I've done on with intel 
vs mips on more than one code, mips doesn't come out nearly as bad 
as you seem to believe. Maybe that is tlb related maybe it is other
issue related. The fact remains.

Later on after your posts I also posted numbers for power 5. Haven't
seen a response to that yet. Maybe you're digesting.

> let's just take Ingo's numbers, measured on modern hardware.

Ingo's numbers calculate 95% tlb misses. I will likely have 100% tlb
misses over most of this code. Read my discussion of what it does
and you'll see why. Capsule form: Every tree node results in several 
thousand nodes that are acceptable. You need to examine several times 
that to get the acceptable ones. Several thousand memory reads from
several thousand different pages means 100% TLB misses. This is by no
means a pathological case. Other codes will have such effects too, as
I noted in my first very long rant.

I may have misread it, but that last bit of difference between 95% 
and 100% tlb misses will be a pretty big factor in speed differences. 
So your 20-40% goes right back up.

Ok, so there is some minimal in my case fp overlap, but a factor 2 
speed difference certainly still exists in the power5 arch numbers I 
quoted. 

I have a special case version of this code that does cache blocking
on the gravity calculation. As a special case version, it is not
effective for the general case. There are 0 TLB misses and 0 L1 misses
for this part of the code. The tree traversal cannot be similarly
cache blocked and keeps all the tlb and cache misses it always had.

For that version, I can get down to 20% speed up, because overall the
traversal only takes 20% or so of the total time. That is the absolute
best I can do, and I've been tuning this code alone for close to a
decade.



Andy

