Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132143AbRCVShr>; Thu, 22 Mar 2001 13:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132131AbRCVShB>; Thu, 22 Mar 2001 13:37:01 -0500
Received: from unthought.net ([212.97.129.24]:47839 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S132147AbRCVSgb>;
	Thu, 22 Mar 2001 13:36:31 -0500
Date: Thu, 22 Mar 2001 19:35:49 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Kevin Buhr <buhr@stat.wisc.edu>
Cc: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010322193549.D6690@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Kevin Buhr <buhr@stat.wisc.edu>,
	"David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vba1yrr7w9v.fsf@mozart.stat.wisc.edu> <15032.1585.623431.370770@pizda.ninka.net> <vbay9ty50zi.fsf@mozart.stat.wisc.edu> <vbaelvp3bos.fsf@mozart.stat.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <vbaelvp3bos.fsf@mozart.stat.wisc.edu>; from buhr@stat.wisc.edu on Thu, Mar 22, 2001 at 12:23:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 12:23:15PM -0600, Kevin Buhr wrote:
> buhr@cs.wisc.edu (Kevin Buhr) writes:
...
> I pulled the "gcc-3_0-branch" of GCC from CVS and compiled Mozilla
> under a 2.4.2 kernel.  The numbers I saw were:
> 
>     real    57m26.850s
>     user    96m57.490s
>     sys     3m16.780s
> 
> which are almost exactly the same as my GCC 2.95.2 numbers.  When I
> peeked at "/proc/<cc1plus>/maps" a few times, I counted ~150 lines,
> not ~2000.  On another, much smaller block of C++ code, I get similar
> results: no dramatic change in kernel time.
> 
> Either the Mozilla codebase and my other test case don't tickle the
> problem, or something has changed in 3.0's allocation scheme since
> RedHat 2.96 was built.

Mozilla uses C++ mainly as "extended C" - due to compatibility concerns.

Try compiling something like Qt/KDE/gtk-- which are really heavy on
templates (with all the benefits and drawbacks of that).

My code here is quite template heavy, and I suspect that's what's triggering
it.  In fact, I can't compile our development code with optimization, because
GCC runs out of memory (it only allocates some 300-500 MB, but each page has
it's own map in /proc/pid/maps, and a wc -l /proc/pid/maps doesn't finish for
minutes).  My typical GCC eats 100-200 MB and runs for several minutes.

You should benchmark this particular case with code that makes GCC eat
lots of memory, 100MB or more.  I've never seen Mozilla really make GCC
eat that much memory  -  other projects do.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
