Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVBPKlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVBPKlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 05:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVBPKlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 05:41:36 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:19800 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261999AbVBPKld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 05:41:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZMh+THtA3mLMPrq1Zy+cXpHMBBnhGe1uhQHsqdklDgCKctjOtQkI8ASPYwO9E256lKgWwWN2/XA9wG0gKqgslG/gEF9LUyIyVlDBsUKieGP/naToSSWrx4FOYc9HT6TtV/Ww/ZlnO6HXMN2xS01CorZefNkRwObEAT5AaGwZmqQ=
Message-ID: <3f250c710502160241222dce47@mail.gmail.com>
Date: Wed, 16 Feb 2005 06:41:32 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
Cc: "Richard F. Rebel" <rrebel@whenu.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1108161173.32711.41.camel@rebel.corp.whenu.com>
	 <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
	 <1108219160.12693.184.camel@blue.obulous.org>
	 <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for responding this email so late. I was busy with my trip.

On Sat, 12 Feb 2005 15:42:15 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> On Sat, 12 Feb 2005, Richard F. Rebel wrote:
> >
> > That said, many mod_perl users are *VERY* interested in being able to
> > detect and observe how "shared" our forked children are.  Shared meaning
> > private pages shared with children (copy on write).  Is it even possible
> > to do this in 2.6 kernels?  If so, any pointers would be very helpful.
> 
> Not in any of the vanilla kernels.
> 
> Mauricio has a /proc/<pid>/smaps patch, in which he returns to looking
> at every pte slot of every vma of the process as /proc/<pid>/statm did
> in 2.4.  I suggest you ask him offline for his latest version (the last
> I saw did not include support for 2.6.11's pud level; 
I put the pud level on the last patch I sent to the linux-kernel list
as suggested by Marcelo Tosatti.

> and looped in an
> inefficient way, repeatedly locating, mapping and unmapping the page
> table for each pte slot - needs refactoring into pgd_range, pud_range,
> pmd_range, pte_range levels like 2.4's statm).
Well, for each vma it is checked how many pages are mapped to rss. So
I have to check per page if it is allocated in physical memory. I know
that this is a heavy function, but do you have any suggestion to
improve this?  What do you mean "needs refactoring into pgd_range,
pud_range, pmd_range, pte_range levels like 2.4's statm"? Could you
give more details, please?

BR,

Mauricio Lin.
