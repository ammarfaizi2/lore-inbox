Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278376AbRJMTkv>; Sat, 13 Oct 2001 15:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278392AbRJMTkh>; Sat, 13 Oct 2001 15:40:37 -0400
Received: from [212.21.93.146] ([212.21.93.146]:1924 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278376AbRJMTii>; Sat, 13 Oct 2001 15:38:38 -0400
Date: Sat, 13 Oct 2001 21:38:20 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, Ulrich Drepper <drepper@redhat.com>,
        Alex Larsson <alexl@redhat.com>, Padraig Brady <padraig@antefacto.com>,
        Andrew Pimlott <andrew@pimlott.ne.mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011013213820.A24539@kushida.jlokier.co.uk>
In-Reply-To: <oupitdx9n2m.fsf@pigdrop.muc.suse.de> <E15oq5j-00056Z-00@calista.inka.de> <20011013172419.B20499@kushida.jlokier.co.uk> <k2669jjz7g.fsf@zero.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <k2669jjz7g.fsf@zero.aec.at>; from ak@muc.de on Sat, Oct 13, 2001 at 06:12:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > Andi Kleen says we can ignore the risk; I disagree, as there are some
> > applications that cannot be trusted if the risk is plausible, and it can
> > be fixed easily.
> 
> You're misquoting me badly.  I said we can ignore the risk that two
> nanosecond resolution timestamps that get changed by two different cpus 
> with out-of-sync cycle counter on a smp system and which are fast enough
> to free/aquire the inode lock in a smaller time than they're out of sync
> (= giving two file changes with the same ns timestamp) can be ignored.
> I implied on the systems that don't have a cycle counter and which use
> jiffie resolution gettimeofday it can be also ignored, because they're
> unlikely to be SMP and dying out too anyways. 

Andi, sorry I misrepresented your statement.

I misread your original as saying that the risks due to SMP nanosecond
scale synchronisation problems can be ignored.  Implied from that, that
the small risk of one SMP process modifying a file while another checks
the timestamp can be ignored.  I misread this way because others have
suggested higher resolution solves the problem, and I believe it does not.

As you say above, multiple modifications within a single tick are not a
problem, do not have to be tracked, and therefore do not require SMP
sychronisation.

The SMP risk of missing a change after checking the timestamp is among
the risks I consider critical for an application which must not miss the
fact that a file has changed.  I do not want us to repeat the mistake of
1 second at a smaller timescale.

cheers,
-- Jamie
