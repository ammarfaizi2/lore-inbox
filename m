Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVBPPCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVBPPCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVBPPCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:02:40 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:21448 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262036AbVBPPCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:02:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QptnKxG0DHy6fjKI5iS+PN2bi1wvkzAW1p7Dhfd5BXAcaVGHQzDf+Zpo9JR3JPukZgHOijnNscahxK9Rpu39NN4g6YkWkGE1nsbAMm+HDyNY0qXlunGjoOrXgUR21ZQEGeZqa7uysaNAViAq8H6yd9L9nwJ9PPzsugtHpNdR4h0=
Message-ID: <3f250c7105021607022362013c@mail.gmail.com>
Date: Wed, 16 Feb 2005 11:02:35 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
Cc: "Richard F. Rebel" <rrebel@whenu.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1108161173.32711.41.camel@rebel.corp.whenu.com>
	 <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
	 <1108219160.12693.184.camel@blue.obulous.org>
	 <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com>
	 <3f250c710502160241222dce47@mail.gmail.com>
	 <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

Thanks by your suggestion. I did not know that kernel 2.4.29 has
changed the statm implementation. As I can see the statm
implementation is different between 2.4 and 2.6.

Let me see if I can use the 2.4.29 statm idea to improve the smaps for
kernel 2.6.11-rc.

BR,

Mauricio Lin.

On Wed, 16 Feb 2005 12:00:55 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> On Wed, 16 Feb 2005, Mauricio Lin wrote:
> > Well, for each vma it is checked how many pages are mapped to rss. So
> > I have to check per page if it is allocated in physical memory. I know
> > that this is a heavy function, but do you have any suggestion to
> > improve this?  What do you mean "needs refactoring into pgd_range,
> > pud_range, pmd_range, pte_range levels like 2.4's statm"? Could you
> > give more details, please?
> 
> Just look at, say, linux-2.4.29/fs/proc/array.c proc_pid_statm:
> which calls statm_pgd_range which calls statm_pmd_range which
> calls statm_pte_range which scans along the array of ptes doing
> the pte examination you're doing.  There are plenty of examples
> in 2.6.11-rc mm/memory.c of how to do it with pud level too.
> 
> Whereas your way starts at the top and descends the tree each time
> for every leaf, repeatedly mapping and unmapping the page table if
> that pagetable is in highmem.  You took follow_page as your starting
> point, which is good for a single pte, but inefficient for many.
> 
> Your function(s) will still be heavyweight, but somewhat faster.
> 
> Hugh
>
