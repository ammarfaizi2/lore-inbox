Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135828AbRD0LME>; Fri, 27 Apr 2001 07:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135915AbRD0LLy>; Fri, 27 Apr 2001 07:11:54 -0400
Received: from mons.uio.no ([129.240.130.14]:13253 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S135828AbRD0LLj>;
	Fri, 27 Apr 2001 07:11:39 -0400
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 NFSv3 client breaks fdopen(3)
In-Reply-To: <20010426192632.A18492@maggie.dt.e-technik.uni-dortmund.de>
	<15080.24119.524229.296133@charged.uio.no>
	<20010427013028.A30741@emma1.emma.line.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Apr 2001 13:11:34 +0200
In-Reply-To: Matthias Andree's message of "Fri, 27 Apr 2001 01:30:28 +0200"
Message-ID: <shsn192a97d.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

     > On Thu, 26 Apr 2001, Trond Myklebust wrote:
    >> Please note that if glibc is checking this return value, it
    >> will still screw up if file->f_pos > 0x7fffffff, which can and
    >> does happen against certain servers (particularly IRIX).

     > Do servers have directories that are this large? It'd take
     > quite some files to get a directory itself (not counting its
     > files) exceed 2 GB, wouldn't it?

Check out IRIX. The xfs filesystem uses full 32 or 64 bit unsigned
cookies on all directories whether they are short or long.

Bottom line: you should not confuse directory cookies with offsets.

    >> As I've said before: it is a bug for glibc to be relying on
    >> seekdir if we want to support non-POSIX compliant filesystems
    >> under Linux.

     > There's no seekdir. No telldir. Just a "get ofile current
     > position".

Same difference.

     > Meanwhile, I took a glance at fileops.c and iofdopen.c of the
     > glibc source RPM that SuSE 7.0 uses, there is no seekdir like
     > stuff involved, it's just that when glibc rolls the dice to get
     > a FILE structure filled, it gathers the current file position,
     > since someone might have called read before fdopen. I think
     > that's legitimate.

     > No seekdir. (would be pointless since seekdir does not return a
     > value) Not even telldir. Just plain fdopen. Is a plain fdopen
     > supposed to fail just because some clients don't understand the
     > semantics some server uses; not even considering who's fault it
     > might be? Certainly not.

File position for an NFS directory can take any 32bit or 64bit
unsigned value. This has been the case on Linux since before glibc2
was even a glimmer in Ulrich Drepper's eye.

Cheers,
   Trond
