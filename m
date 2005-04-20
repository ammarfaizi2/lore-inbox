Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVDTMLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDTMLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDTMLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:11:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16516 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261546AbVDTMJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:09:14 -0400
Date: Wed, 20 Apr 2005 14:08:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Thomas Renninger <trenn@suse.de>, Tony Lindgren <tony@atomide.com>,
       Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
Message-ID: <20050420120846.GA21897@elf.ucw.cz>
References: <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de> <20050419152723.GA9509@isilmar.linta.de> <42657222.5080601@suse.de> <20050420114433.GA28362@isilmar.linta.de> <20050420115739.GB16819@elf.ucw.cz> <20050420120102.GB28491@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420120102.GB28491@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Because I don't consider whether there was bm_activity the last ms, I only
> > > > consider the average, it seems to happen that I try to trigger
> > > > C3/C4 when there is just something copied and some bm active ?!?
> > > 
> > > I don't think that this is perfect behaviour: if the system is idle, and
> > > there is _currently_ bus master activity, the CPU should be put into C1 or
> > > C2 type sleep. If you select C3 and actually enter it, you're risking
> > > DMA issues, AFAICS.
> > 
> > What kinds of DMA issues? Waiting 32msec or so is only heuristic; it
> > can go wrong any time. It would be really bad if it corrupted data or
> > something like that.
> 
> loop()
>    a) bus mastering activity is going on at the very moment
>    b) the CPU is entering C3
>    c) the CPU is woken out of C3 because of bus mastering activity
> 
> the repeated delay between b) and c) might be problematic, as can be seen
> by the comment in processor_idle.c:
> 
>                  * TBD: A better policy might be to fallback to the demotion
>                  *      state (use it for this quantum only) istead of
>                  *      demoting -- and rely on duration as our sole demotion
>                  *      qualification.  This may, however, introduce DMA
>                  *      issues (e.g. floppy DMA transfer overrun/underrun).
>                  */
> 
> I'm not so worried about floppy DMA but about the ipw2x00 issues here.

Like "ipw2x00 looses packets" if this happens too often?

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
