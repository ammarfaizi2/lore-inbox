Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289222AbSA1PaU>; Mon, 28 Jan 2002 10:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289219AbSA1PaJ>; Mon, 28 Jan 2002 10:30:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63617 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289218AbSA1PaC>; Mon, 28 Jan 2002 10:30:02 -0500
Date: Mon, 28 Jan 2002 10:32:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alex Davis <alex14641@yahoo.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: Don't use dbench for benchmarks
In-Reply-To: <20020128144319.67654.qmail@web9203.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020128100010.15936A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Alex Davis wrote:

> 
> --- Daniel Phillips <phillips@bonn-fries.net> wrote:
> > On January 27, 2002 05:35 am, Alex Davis wrote:
> > > I ran dbench on three different kernels: 2.4.17 w/ rmap12a, 2.4.18pre7, and
> > > 2.4.18pre7 w/ rmap12a. 2.4.18pre7 had better throughput by a substantial 
> > > margin. The results are at http://www.dynamicbullet.com/rmap.html
> > 
> > I must be having a bad day, I can only think of irritable things to post.
> I don't consider this "irritable".
> > Continuing that theme: please don't use dbench for benchmarks.  At all.
> > It's an unreliable indicator of anything in particular except perhaps
> > stability.  Please, use something else for your benchmarks.
> What do you suggest as an acceptable benchmark??? 
> 

A major problem with all known benchmarks is that, once you define one,
an OS can be tuned to maximize perceived performance while, in fact,
destroying other "unmeasurables" like "snappy interactive performance".

It seems that compiling the Linux Kernel while burning a CDROM gives
a good check of "acceptable" performance. But, such operations are
not "benchmarks". The trick is to create a benchmark that performs
many "simultaneous" independent and co-dependent operations using
I/O devices that everyone is likely to have. I haven't seen anything
like this yet.

Such a benchmark might have multiple tasks performing things like:

(1)	Real Math on large arrays.

(2)	Data-base indexed lookups.

(3)	Data-base keys sorting.

(4)	Small file I/O with multiple creations and deletions.

(5)	Large file I/O operations with many seeks.

(6)	Multiple "network" Client/Server tasks through loop-back.

(7)	Simulated compiles by searching directory trees for
	"include" files, reading them and closing them, while
	performing string-searches to simulate compiler parsing.

(8)	Two or more tasks communicating using shared-RAM. This
	can be a "nasty" performance hog, but tests the performance
	of threaded applications without having to write those
	applications.

(9)	And more....


These tasks would be given a "performance weighting value", a heuristic
that relates to perceived overall performance. But, even this is
full of holes. You could tune a fast machine with much RAM and then
have terrible performance with machines that sleep, waiting for I/O.

So, one of the first things that has to be done, before any benchmark
can attempt to be valid, is to stabililize the testing environment.
This is difficult to do under software control. For instance,
if I had a RAM-eater which was going to use up RAM until there was
only a certain amount left, I would need to prevent the RAM-eater from
using the CPU after it had performed its work. The RAM-eater would
have to lock pages into place, pages it would not be accessing during
the rest of the benchmark. If I didn't do this, the kernel would
be spending a lot of time swapping, messing up benchmark results.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


