Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271817AbRHRMjz>; Sat, 18 Aug 2001 08:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271818AbRHRMjp>; Sat, 18 Aug 2001 08:39:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30076 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271817AbRHRMjZ>; Sat, 18 Aug 2001 08:39:25 -0400
To: tegeran@home.com
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.4.30.0108171200510.4065-100000@anime.net>
	<m1snepoft6.fsf@frodo.biederman.org> <01081803242800.00266@c779218-a>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Aug 2001 06:32:26 -0600
In-Reply-To: <01081803242800.00266@c779218-a>
Message-ID: <m1elq9o8f9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight <tegeran@home.com> writes:

> On Saturday 18 August 2001 02:52 am, Eric W. Biederman wrote:
> > Dan Hollis <goemon@anime.net> writes:
> > > On 17 Aug 2001, Eric W. Biederman wrote:
> > > > Clearing memory on most machines takes a 1s or less.  Think of
> > > > memory fill rates at the 800MB/s level.  Most BIOS's seem to clear
> > > > some of the memory but I haven't read their code to see what they
> > > > are doing.
> > >
> > > Ive measured rates far lower than that, at least for SDRAM.
> >
> > Hmm.  The numbers were off the top of my head and I've been messing
> > with DDR SDRAM quite a bit so I may have doubled it.   Hmm.
> >
> > Nope.  I was remember something close to the typical streams numbers
> > on an Athlon with DDR SDRAM.  Since those are read-modify-write
> > numbers they should be close to the write numbers for normal SDRAM.
> >
> > With a PII/PIII and PC100 SDRAM I have measured about 640 MB/s writes.
> >
> 
> I'm not sure where you're pulling these numbers from, but being a 
> hardcore FPS gamer, I can tell you from experience, PC100 SDRAM does NOT 
> hit 640MB/sec! Esspecialy not on a PII! PC100 SDRAM on my current 800Mhz 
> non-tbird Athlon currently peaks near 250MB/sec

The actual tests results are somewhere at the office, but the figures are
in the right ballbark.  I'm not saying this is a common case, or easy
to get.  640 maybe be a little high but I know it was over 600MB/s. 
With carefully tuned code this is what you can get.  

Basically setting up an MTRR that does write-combining, on the area of
memory you are talking about so that you do not go through the cache.
Then something like ``xorl %eax, %eax; movl $0x1000000; rep stosl''
should achieve that kind of fill rate.  I have watched it on a logic
analyzer connected to instrumented DIMMs.  So I know it was making all
of the way to the RAM.  

You should be able to make it to SDRAM through the cache at this kind
of speed as well, but that wasn't the case I was interested at the
time I made the test.

When I performed the experiment I know it was a processor running the
P6 core and running on the l440GX motherboard, and that the memory
was PC100.

Between 600MB/s and 700MB/s is the theoretical peak of writes
on PC100 SDRAM.  So you can't do much better.  On the other hand you
should be coming much closer than 250MB/s.

The actually calculation for PC100 SDRAM using a burst length of 8 and
never refreshing goes like this.   There is one additional clock used
for the command byte on the SDRAM bus.
100*1000*1000hz * 8 bytes per clock * 8/9 / (1024*1024)  == 678 MB/s


Eric
