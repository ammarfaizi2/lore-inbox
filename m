Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280749AbRKBRvf>; Fri, 2 Nov 2001 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280748AbRKBRvZ>; Fri, 2 Nov 2001 12:51:25 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:7940 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S280747AbRKBRvT>;
	Fri, 2 Nov 2001 12:51:19 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15330.56589.291830.542215@abasin.nj.nec.com>
Date: Fri, 2 Nov 2001 12:51:09 -0500 (EST)
To: linux-kernel@vger.kernel.org
Cc: Daniel Phillips <phillips@bonn-fries.net>, Ben Smith <ben@google.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <3BE07730.60905@google.com>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin>
	<E15z28m-0000vb-00@starship.berlin>
	<20011031214540.D1291@athlon.random>
	<E15z2WJ-0000wc-00@starship.berlin>
	<3BE07730.60905@google.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Smith writes:
 >  > On October 31, 2001 09:45 pm, Andrea Arcangeli wrote:
 >  >
 >  >>On Wed, Oct 31, 2001 at 09:39:12PM +0100, Daniel Phillips wrote:
 >  >>
 >  >>>On October 31, 2001 07:06 pm, Daniel Phillips wrote:
 >  >>>
 >  >>>>I just tried your test program with 2.4.13, 2 Gig, and it ran
 >  >>>>without problems.  Could you try that over there and see if you
 >  >>>>get the same result?  If it does run, the next move would be to
 >  >>>>check with 3.5 Gig.
 >  >>>>
 >  >>>Ben reports that his test with 2 Gig memory runs fine, as it does
 >  >>>for me, but that it locks up tight with 3.5 Gig, requiring power
 >  >>>cycle.  Since I only have 2 Gig here I can't reproduce that (yet).
 >  >>>
 >  >>are you sure it isn't an oom condition. can you reproduce on
 >  >>2.4.14pre5aa1? mainline (at least before pre6) could deadlock with
 >  >>too much mlocked memory.
 >  >>
 >  >
 >  > I don't know, I can't reproduce it here, I don't have enough memory.
 >  > Ben?
 > 
 > My test application gets killed (I believe by the oom handler). dmesg
 > complains about a lot of 0-order allocation failures. For this test,
 > I'm running with 2.4.14pre5aa1, 3.5gb of RAM, 2 PIII 1Ghz.
 >   - Ben
 > 
 > Ben Smith
 > Google, Inc
 > 


This is a System with 4G of memory and regular swap.  With 2 Pentium
III 1Ghz processors.

On 2.4.14-pre6aa1 it happily runs until:

munmap'ed 7317d000
Loading data at 7317d000 for slot 2
Load (/mnt/sdb/sven/chunk10) succeeded!
mlocking slot 2, 7317d000
mlocking at 7317d000 of size 1048576
Connection to hera closed by remote host.
Connection to hera closed.

Where is kills my ssh and other programs.  fills my /var/log/messages
with:

Nov  2 11:29:07 ps2 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Nov  2 11:29:07 ps2 syslogd: select: Cannot allocate memory
Nov  2 11:29:07 ps2 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Nov  2 11:29:07 ps2 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Nov  2 11:29:07 ps2 last message repeated 2 times

a bunch of times.  Then doesn't free the mmaped memory until file
system is unmounted.  It never starts going into swap.

2.4.14-pre5aa1 does about the same.

	       Sven
