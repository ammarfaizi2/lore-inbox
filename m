Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285566AbRLSXY3>; Wed, 19 Dec 2001 18:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285568AbRLSXYT>; Wed, 19 Dec 2001 18:24:19 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:18587 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S285566AbRLSXYK> convert rfc822-to-8bit; Wed, 19 Dec 2001 18:24:10 -0500
Subject: Re: Poor performance during disk writes
From: jlm <jsado@mediaone.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011218195509.U2272-100000@gerard>
In-Reply-To: <20011218195509.U2272-100000@gerard>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 19 Dec 2001 18:26:52 -0500
Message-Id: <1008804413.926.5.camel@PC2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-18 at 14:09, Gérard Roudier wrote:
> 
> 
> On Tue, 18 Dec 2001, Andre Hedrick wrote:
> 
> > On Tue, 18 Dec 2001, Gérard Roudier wrote:
> >
> > >
> > >
> > > On Tue, 18 Dec 2001, Andre Hedrick wrote:
> > >
> > > > File './Bonnie.2276', size: 1073741824, volumes: 1
> > > > Writing with putc()...  done:  72692 kB/s  83.7 %CPU
> > > > Rewriting...            done:  25355 kB/s  12.0 %CPU
> > > > Writing intelligently...done: 103022 kB/s  40.5 %CPU
> > > > Reading with getc()...  done:  37188 kB/s  67.5 %CPU
> > > > Reading intelligently...done:  40809 kB/s  11.4 %CPU
> > > > Seeker 2...Seeker 1...Seeker 3...start
'em...done...done...done...
> > > >               ---Sequential Output (nosync)--- ---Sequential
Input-- --Rnd Seek-
> > > >               -Per Char- --Block--- -Rewrite-- -Per Char-
--Block--- --04k (03)-
> > > > Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec
%CPU   /sec %CPU
> > > >        1*1024 72692 83.7 103022 40.5 25355 12.0 37188 67.5 40809
11.4  382.1  2.4
> > > >
> > > > Maybe this is the kind of performance you want out your ATA
subsystem.
> > > > Maybe if I could get a patch in to the kernels we could all have
stable
> > > > and fast IO.
I think people might be missing the issue that I'm having, here. Let me
see if I can clarify. I'm not too concerned about write speed. I don't
care too much if the hard drive can only write one byte per second. The
problem is that when the kernel decides to write out to the disk, it is
pre-empting everything else. All output to the user in X, the sound
card, and also text typing in the console is put "on the back burner"
while the disk is written to.

It seems to me that smaller chunks of data can be written to the disk
without disrupting my use of the computer (which is the case with
untarring a small file, for instance), so if the kernel has got a lot to
write to disk, just do that as a bunch of smaller writes and we should
be fine.

So I guess I don't really care what mode the hard drive is operating in
(udma, mdma, dma or plain ide), I just don't want to have to go get a
cup of coffee while the hard drive saves some data. Is there a "don't
pre-empt the rest of the system" switch for the eide drives? Is there
something fundamental/unique going on here that I'm missing?

Thanks for listening.
> > >
> > > I rather see lots of wasting rather than performance, here. Bonnie
says
> > > that your subsystem can sustain 103 MB/s write but only 41 MB/s
read. This
> > > looks about 60% throughput wasted for read.
> > >
> > > Note that if you intend to use it only for write-only
applications,
> > > performance are not that bad, even if just dropping the data on
the floor
> > > would give you infinite throughput without any difference in
> > > functionnality. :-)
> >
> > Well sense somebody paid/paying me make write performance go through
the
> > roof -- that is what I did.  Now if you look closely you could see
that in
> > writing we are doing a boat load more work than reading.  If
somebody want
> > me to throttle the reads more then they know how to get it done.
> 
> I am not the one that will pay you for that, as you can guess. :-)
> 
> I just was curious about the technical reasons, if any, of so large a
> difference. Just, the CPU and the memory subsystem are certainly not
the
> issue. But I donnot want to prevent you from earning from such kind of
> improvement. Hence, let me go back to free scsi.

-- 
MACINTOSH = Machine Always Crashes If Not The Operating System Hangs
"Life would be so much easier if we could just look at the source code."
- Dave Olson

