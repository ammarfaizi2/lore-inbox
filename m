Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277419AbRJEPfH>; Fri, 5 Oct 2001 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277417AbRJEPfA>; Fri, 5 Oct 2001 11:35:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61492 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277419AbRJEPet>; Fri, 5 Oct 2001 11:34:49 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: riel@conectiva.com.br (Rik van Riel),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <E15pWQA-0006bs-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Oct 2001 09:25:09 -0600
In-Reply-To: <E15pWQA-0006bs-00@the-village.bc.nu>
Message-ID: <m1669uyuqy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > We (as in Linux) should make sure that we explicitly tell the disk when
> > > we need it to flush its disk buffers. We don't do that right, and
> > > because of _our_ problems some people claim that writeback caching is
> > > evil and bad.
> > 
> > Does this even work right for IDE ?
> 
> Current IDE drives it may be a NOP. Worse than that it would totally ruin
> high end raid performance. We need to pass write barriers. A good i2o card
> might have 256Mb of writeback cache that we want to avoid flushing - because
> it is battery backed and can be ordered.

If the cache is small and is primarily a track cache (IDE) one trick that
we can do is to flood the cache with data so everything is forced out.

We can do this at mkfs time, (so even destructive tests are allowed)
and we can probe how to make this work for a particular drive.  And
then the kernel can just use the results of that probe. 

> By all means have drivers fall back to cache writeback, but don't assume
> that is the basic operation.

Definentily.  We want a write-barrier however we can get it.
 
> Indeed a smarter raid card can generally do

Eric
