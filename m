Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317492AbSFIBKj>; Sat, 8 Jun 2002 21:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSFIBKi>; Sat, 8 Jun 2002 21:10:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55569 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317492AbSFIBKi>;
	Sat, 8 Jun 2002 21:10:38 -0400
Date: Sun, 9 Jun 2002 02:10:38 +0100
From: "Dr. David Alan Gilbert" <linux@spamtrap.treblig.org>
To: linux-kernel@vger.kernel.org
Subject: kernel ram testing
Message-ID: <20020609011038.GA1078@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 01:53:38 up 13:21,  7 users,  load average: 2.72, 2.73, 2.73
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  After a particularly odd experience with a duff dimm a few weeks ago*  I
started thinking again about building continuous RAM testing into the kernel.

I've so far put together a little piece of code that regularly checksums
the kernel text (from _text to _etext).  But now I have some questions:

 1) _text and _etext seem to be defined differently on different
 architectures (some don't define both).  Ideally I think I'd like just
 the kernel text in a way that can be extracted with objdump at build
 time (so I can calculate the sum then for comparison). Suggestions on
 whether _text and _etext are appropriate would be useful.

 2) I want to test the rest of RAM as well - as much as possible,
 repeatedly while the system is running.  I could repeatedly allocate,
 test and deallocate a page. But will I keep getting the same page
 rather than circling through the rest of RAM? Can I ask for particular
 physical pages portably?

 3) I also want to test pages that are being used by the buffers and
 processes; I'd really like to kick a page onto a different physical
 page so I can test it - is this easily possible? (I could lock the
 whole machine down, copy the page somewhere else and then test it, but
 I fear this would take too long).


At the moment my code lives in a kernel thread (kintegrityd) that runs
and then sleeps for a while before running again (at lowest priority
above idle). (I'm presently fiddling with this under user mode linux
2.4.18).

Thoughts and suggestions welcome.

Dave

(*) The DIMM appears, from memtest86, to have had an approximately 4MB
range where one bit in 32bits (or was it perhaps wider) was stuck low.
First noticed by a mismatch on md5sums of a downloaded debian package
and by ' characters appearing in an od I did of the corrupted package on
a machine that otherwise appeared stable.

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
