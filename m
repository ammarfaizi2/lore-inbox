Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbULPOUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbULPOUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbULPOUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:20:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8578 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262665AbULPOUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:20:06 -0500
Subject: Re: arch/xen is a bad idea
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
In-Reply-To: <20041216140954.GA29761@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de>
	 <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
	 <20041215044927.GF27225@wotan.suse.de>
	 <1103155782.3585.29.camel@localhost.localdomain>
	 <20041216040136.GA30555@wotan.suse.de>
	 <1103201656.3804.7.camel@localhost.localdomain>
	 <20041216140954.GA29761@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103203145.3804.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 13:19:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 14:09, Andi Kleen wrote:
> Also e.g. for non performance critical 
> things like changing MTRRs or debug registers it would be IMHO much 
> cleaner to just emulate the instructions (the ISA is very well 
> defined) and not change the kernel here.  From a look at Ian's list
> the majority of the changes needed for Xen actually fall into
> this category. 

There are so many problems in snooping and decoding instructions it
isn't funny. Aside from the mmap pci buffer half way through instruction
that will emulate type stuff there are a lot of awkward issues if you
want to emulate multiple mtrr sets (you need PAT).

Xen has tried the decode/patch stuff earlier - see the early NPTL
handling and it was neither pretty nor reliable.

