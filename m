Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316954AbSFGHiu>; Fri, 7 Jun 2002 03:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSFGHit>; Fri, 7 Jun 2002 03:38:49 -0400
Received: from mail.ispwest.com ([216.52.245.18]:53765 "EHLO
	ispwestemail.aceweb.net") by vger.kernel.org with ESMTP
	id <S316954AbSFGHit>; Fri, 7 Jun 2002 03:38:49 -0400
Date: Fri, 7 Jun 2002 02:38:51 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: mmap /proc/<pid>/mem ... alternatives?
Message-ID: <20020607073851.GA24365@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a black-box process (of which I can disassemble enough to
insert debugging traps).  I need to read a large number of sparse
structures that are a few bytes to a few hundred kbyte each.  In
Linux 2.2, I was simply mmap()ing the process's memory, but that
feature seems removed in Linux 2.4, so.. I need alternatives..

Here's a list of things I'm considering:

	provide mmap() patch for /proc/<pid>/mem
		Definitely out of my league :)

	mmap() of /dev/mem
		needs root (I can live with that)

		need to know where the process's memory is --
		  I don't know how to determine this.

	shared memory
		need to bootstrap some code at the beginning (doable)

		I don't know how to re-map the data, bss, and stack to
		  shared memory properly.

	use read/write on /proc/<pid>/mem
		write() doesn't work (doesn't write to the process).

		complicates the code in my program quite a bit.

	hybrid read, ptrace(PTRACE_POKEDATA, ...)
		works, but I would like to avoid all the extra copies,
		  and this complicates the code quite a bit.

	downgrade to 2.2
		Only as an absolute last resort, if nothing else works.

-- 
Zinx Verituse
