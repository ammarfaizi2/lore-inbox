Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269043AbRHLKSi>; Sun, 12 Aug 2001 06:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269049AbRHLKS2>; Sun, 12 Aug 2001 06:18:28 -0400
Received: from mail.direcpc.com ([198.77.116.30]:33929 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S269043AbRHLKSY>; Sun, 12 Aug 2001 06:18:24 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
From: Jeffrey Ingber <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <997611708.29909.22.camel@DESK-2>
In-Reply-To: <20010811225232.A19327@thyrsus.com> 
	<997611708.29909.22.camel@DESK-2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 12 Aug 2001 06:23:33 -0400
Message-Id: <997611819.29909.25.camel@DESK-2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 11 Aug 2001 22:52:32 -0400, Eric S. Raymond wrote:
 
> The evidence for this is indirect but strong.  The hang happened in every
> pre-2.4.8 configuration we tested if there was an SB Live! actually in the
> machine.  It never happened if either 2.4.8 was running or the SB Live! was
> removed.  This theory also accounts for our failure to observe hangs during

I've used ALSA for quite awhile for EMU10k1 (E-MU APS, not SBLive) and
have had no problems.  I noticed that the EMU10K1 driver was updated in
2.4.8 so I tried it.  I had a lockup four times during audio playback,
so I switched back to ALSA and now everything is stable once again.

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)

> 
> > moderate to intense X GUI activity -- that traffic was going over the AGP
> > bus, and we had enough memory in the box that it never swapped.
> > 
> > Now that we seem to be out of the woods, I can cop to why I'm doing
> > qualification tests on bleeding-edge PCs.  I'm writing an article for
> > Linux Journal on building the ultimate Linux box.  I won't spoil the
> > surprise by telling you what else is in the machine, but I will tell
> > you that it is jaw-droppingly fast and sexy hardware and that you'll
> > get to read all about it before the end of the year.
> > 
> > In the meantime, here is my draft writeup on the hang problem:
> > 
> > <sect1 id='horror_story'><title>The Inevitable Horror Story</title>
> > 
> > <para>Sadly, life got much less pleasant for quite a while after that. We
> > started seeing mysterious hangs -- the machine would lock up hard and
> > random intervals, usually during disk I/O operations.  This is almost the
> > worst kind of problem to troubleshoot, as it leaves no clues other than the
> > bare fact of the machine's catatonia -- you get no oops message, and all
> > the state you might have used to post-mortem disappears when the machine is
> > reset.  The only kind of problem that's worse is one that adds
> > irreproducibility to the catatonia.  But fortunately, we found that doing
> > <command>make clean</command> or <command>make world</command> on an X
> > source tree produced the hang pretty reliably.</para>
> > 
> > <para>Approximately thirty hours of troubleshooting (interrupted by far too
> > little sleep) ensued as Gary and I tried to track down the problem.  We
> > formed and discarded lots of theories based on where we had not yet seen
> > the hang.  For a while we thought the problem only bit in console mode, not
> > in X mode. For another while we thought it happened only under SMP kernels.
> > For a third while we thought we could avoid it by compiling kernels for the
> > Pentium II rather than the Athlon. All these beliefs were eventually
> > falsified amidst much wailing and gnashing of teeth.</para>
> > 
> > <para>Once it became clear that there was a problem at or near the hardware
> > level, we still had a lot of hypotheses to choose from -- with all of them
> > having pretty unpleasant ramifications for our chances of qualifying this
> > box before I had to fly home.  Quite possibly the motherboard was bad.  Or
> > we might have been seeing thermal flakeouts due to insufficient cooling of
> > the motherboard chips or memory.</para>
> > 
> > <para>About eighteen hours in, just before we both crashed in exhaustion,
> > we posted the problem to the <email>linux-kernel</email> mailing list.  We
> > got a rather larger number of responses than we expected (nearly twenty)
> > within a few hours.  Several were quite helpful.  And the breakthrough came
> > when a couple of linux-kernel people confirmed that the SB Live! is a
> > frequent source of hangs and lockups on other fast PCI machines.  With a
> > few more hours of testing (during which our X source tree probably got
> > cleaned and rebuilt more times than is allowed by law) we satisfied
> > ourselves that the lockups stop happening when the SB Live! has been
> > summarily yanked from the machine.</para>
> > 
> > <para>The most helpful advice we got came from one Daniel T. Chen, who
> > reported that he had nailed some similar lockups to the SB Live! running
> > over a Via chipset -- and that they stopped when he upgraded to 2.4.8 and
> > the newest version of the emu10k1 driver.  So while Gary took a much-needed
> > break (and his wife and kids to a David Byrne concert), I built 2.4.8 (with
> > emu10k1.o hard-compiled in) and ran our torture test -- first with the SB
> > Live! omitted, and then with it in the machine.  No hang.  Victory!</para>
> > 
> > <para>Perhaps it's belaboring the obvious, but the way this problem got
> > resolved was yet another testimony to the power of open-source development
> > and the community that has evolved around it.  Once again, our
> > technology and our social machine complemented each other and delivered
> > the goods.</para>
> > -- 
> > 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> > 
> > What is a magician but a practicing theorist?
> > 	-- Obi-Wan Kenobi, 'Return of the Jedi'
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 


