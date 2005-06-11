Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVFKKlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVFKKlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 06:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFKKlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 06:41:47 -0400
Received: from one.firstfloor.org ([213.235.205.2]:31648 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261677AbVFKKlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 06:41:45 -0400
To: martin@cs.uga.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with
 Memhole Mapping (non tainted kernel)
References: <200506071836.12076.martin@cs.uga.edu>
From: Andi Kleen <ak@muc.de>
Date: Sat, 11 Jun 2005 12:41:44 +0200
In-Reply-To: <200506071836.12076.martin@cs.uga.edu> (Jacob Martin's message
 of "Tue, 7 Jun 2005 18:36:12 -0400")
Message-ID: <m1wtp1ch07.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob Martin <martin@cs.uga.edu> writes:

> On second thought, the MTRR stuff may not have anything to do with this.

I think it has or the strange software memhole (what is that?)
 
>
>
> I think this is a bug in the preemptable kernel (I was warned, but didn't listen :).  

You could verify that by disabling PREEMPT. Butactually it should
not be that bad.

>From your oopses i more suspect it is hardware actually:

> Jun  7 14:11:27 optimator Unable to handle kernel paging request at 00000000000025b0 RIP: 
> Jun  7 14:11:27 optimator <ffffffff8016797a>{pte_alloc_map+170}

It crashes on first accessing newly allocated memory for page tables.

Most likely something is wrong with your memory or memory map.
Maybe it is related to your "discrete mtrr mapping" or your "software
memhole" whatever they are? I would suggest to try without these.

-Andi
 
