Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSGOOqy>; Mon, 15 Jul 2002 10:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGOOqy>; Mon, 15 Jul 2002 10:46:54 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:17395 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317499AbSGOOqx>;
	Mon, 15 Jul 2002 10:46:53 -0400
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
References: <20020715075221.GC21470@uncarved.com>
	<Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com>
	<20020715133507.GF32155@merlin.emma.line.org>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 10:49:46 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20020715133507.GF32155@merlin.emma.line.org>
Message-ID: <s5gwurxt59x.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> We had a similar discussion along the lines of an MTA roughly a year
> ago, but without your (unquoted) objection that fsync() on a fiel
> without write permit should be impossible.

It was a long thread:

  http://groups.google.com/groups?threadm=linux.kernel.3B5FC7FB.D5AF0932%40zip.com.au

  http://lists.insecure.org/linux-kernel/2001/Aug/index.html#39

> The essence was that Linux 2.4 ext3fs and reiserfs guarantee that on
> fsync(), the file is recoverable from the place it was created, 2.2 was
> halfway there; but beware: only data=ordered or data=journal (in ext3fs,
> as beta patch for reiserfs from
> ftp.suse.com:/pub/people/mason/patches/data-logging/ <- from memory))
> will guarantee that your file contents are recoverable.

I do not recall anything about data=ordered or data=journal mode being
required.  I thought someone authoritative (Stephen Tweedie?) said
that ext3 happens to commit the journal on fsync(), independent of the
journaling mode, but that this behavior was an implementation
coincidence and not guaranteed.  (Unfortunately, I am having trouble
finding that message...  Can someone familiar with the source confirm
or deny this?)

I would love to know what IS guaranteed.  This fsync() question keeps
cropping up, and as far as I know there is no authoritative statement
anywhere about what Linux promises.  "Read the source code" is the
wrong answer; implementations can change at any time.  This is a
question about the interface, not the implementation.  "See post XXX
on linux-kernel" is almost as bad.

> That aside, it would really useful to get this "hog a writer" issue
> ironed out either way, and that the illogical "fsync() a O_RDONLY"
> file be resolved somehow.

It is a non-issue; no resolution is necessary.  If I can even read or
write a single file on the same DISK (or bus) that some server process
uses, I can "hog its resources" and slow it down.  Horrors!  Is there
any solution???  Oh yeah, don't let me do that.

The only interesting question here is what the relevant standards say.
And if they allow fsync() at all on a read-only descriptor, then there
is pretty clearly only one thing that can mean.  If you have a problem
with this behavior, then configure your precious servers to keep their
data unreadable by untrusted parties.

> Is fsync()ing directories any portable?

No, but apparently it is what Linux supports.  If this were documented
clearly somewhere, maybe application authors could be convinced to
support it.

 - Pat
