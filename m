Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275981AbRJGBBE>; Sat, 6 Oct 2001 21:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275982AbRJGBAz>; Sat, 6 Oct 2001 21:00:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29751 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S275981AbRJGBAl>; Sat, 6 Oct 2001 21:00:41 -0400
To: Pavel Machek <pavel@Elf.ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <E15pWQA-0006bs-00@the-village.bc.nu>
	<m1669uyuqy.fsf@frodo.biederman.org> <20011006000527.A1306@elf.ucw.cz>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 06 Oct 2001 18:51:25 -0600
In-Reply-To: <20011006000527.A1306@elf.ucw.cz>
Message-ID: <m17ku8xofm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@Elf.ucw.cz> writes:

> Hi!
> 
> > > > > We (as in Linux) should make sure that we explicitly tell the disk when
> > > > > we need it to flush its disk buffers. We don't do that right, and
> > > > > because of _our_ problems some people claim that writeback caching is
> > > > > evil and bad.
> > > > 
> > > > Does this even work right for IDE ?
> > > 
> > > Current IDE drives it may be a NOP. Worse than that it would totally ruin
> > > high end raid performance. We need to pass write barriers. A good i2o card
> > > might have 256Mb of writeback cache that we want to avoid flushing - because
> 
> > > it is battery backed and can be ordered.
> > 
> > If the cache is small and is primarily a track cache (IDE) one trick that
> > we can do is to flood the cache with data so everything is forced out.
> > 
> > We can do this at mkfs time, (so even destructive tests are allowed)
> > and we can probe how to make this work for a particular drive.  And
> > then the kernel can just use the results of that probe. 
> 
> How do you probe this without actually powering system down?

You can't be 100% certain.  But you can do timings.  And usually you can
infer what is happening in the caches from that.  For example if you
take timings with the cache enabled and disabled, and the speed is the
same you can be fairly confident that the caches doen't disable.

Having a final verification step where you ask the user to pull the plug
could add some extra confidence.  But even then weird cases of buggy
firmware could defeat you.

Eric





