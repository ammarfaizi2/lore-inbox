Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288136AbSAHPkW>; Tue, 8 Jan 2002 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288135AbSAHPkN>; Tue, 8 Jan 2002 10:40:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288130AbSAHPkB>; Tue, 8 Jan 2002 10:40:01 -0500
Date: Tue, 8 Jan 2002 16:39:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108163925.F1894@inspiron.school.suse.de>
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br> <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jan 08, 2002 at 11:59:36AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:59:36AM -0200, Marcelo Tosatti wrote:
> 
> 
> On Tue, 8 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> 
> > Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or 
> > -rmap?
> 
> -rmap is 2.5 stuff. 
> 
> I would really like to integrate -aa stuff as soon as I can understand
> _why_ Andrea is doing those changes.
> 
> Note that people will _always_ complain about VM: It will always be
> possible to optimize it to some case and cause harm to other cases.

At the moment I've one showstopper thing to fix (enterprise thing only
though, normal boxes doesn't care about this), then I will try to split
out those bits for integration and they should become much more readable.

> 
> I'm not saying that VM is perfect right now: It for sure has problems.
> 
> > Andrew Morten`s read-latency.patch is a clear winner for me, too.
> 
> AFAIK Andrew's code simply adds schedule points around the kernel, right? 
> 
> If so, nope, I do not plan to integrate it.

Note that some of them are bugfixes, without them an luser can hang the
machine for several seconds on any box with some giga of ram by simple
reading and writing into a large enough buffer. I think we never had
time to care merging those bits into mainline yet and this is probably
the main reason they're not integrated but it's something that should be
in mainline IMHO.

> > What about 00_nanosleep-5 and bootmem?
> 
> What is 00_nanosleep-5 and bootmem ? 

nanosleep gives usec resolution to the rest-of-time returned by
nanosleep, this avoids glibc userspace starvation on nanosleep
interrupted by a flood of signals. It was requested by glibc people.

I know nanosleep triggers ltp failures (both kindly reported by Paul
Larson and Randy Hron), but I really suspect a false positive in the ltp
testsuite, I didn't had time to check it yet, but certainly I tested
nanosleep retval usec resolution with some testcase written by hand
(compared to gettimeofday output) after writing it long ago, and it was
apparently working fine and I never had problems with it yet.

Andrea
