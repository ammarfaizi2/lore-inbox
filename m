Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUEPFzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUEPFzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 01:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUEPFy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 01:54:59 -0400
Received: from nacho.zianet.com ([216.234.192.105]:20489 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S263163AbUEPFy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 01:54:57 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sat, 15 May 2004 23:54:25 -0600
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
References: <200405132232.01484.elenstev@mesatop.com> <200405152231.15099.elenstev@mesatop.com> <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405152354.26083.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 May 2004 10:52 pm, Linus Torvalds wrote:
> 
> On Sat, 15 May 2004, Steven Cole wrote:
> > 
> > OK, will do.  I ran the bk exerciser script for over an hour with 2.6.6-current
> > and no CONFIG_PREEMPT and no errors.  The script only reported one
> > iteration finished, while I got it to do 36 iterations over several hours earlier
> > today (with a 2.6.3-4mdk vendor kernel)
> 
> Hmm.. Th ecurrent BK tree contains much of the anonvma stuff, so this 
> might actually be a serious VM performance regression. That could 
> effectively be hiding whatever problem you saw.

[steven@spc steven]$ vmstat -n 1 15
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  16644   3056   5288  71752   13   25   652   357 3024   357 36 35  6 22
 0  1  16644   2832   5288  72036    0    0  1052     0 3155   300 20 29  0 51
 1  0  16644   2708   5284  72072    0    0   788     0 2586   333 19 26  0 55
 0  2  16644   3216   5288  71976    0    0   932     0 2850   291 20 26  0 54
 1  1  16644   2832   5292  72500    0    0  1036     0 3093   329 20 30  0 50
 0  1  16644   3088   5264  72688    0    0  1000   303 3561   449 21 35  0 43
 0  2  16644   3216   5276  72384    0    0   720     0 2475   335 19 23  0 58
 1  1  16644   2848   5292  72440   60    0   763     0 2544   372 18 25  0 58
 0  3  16644   3152   5172  72136    0    0   776     4 2530   392 20 24  0 55
 0  1  16644   3216   5200  71848    0    0   945     0 2893   375 20 27  0 53
 1  1  16644   2512   5464  71488    0    0   924   260 2899   364 18 26  0 56
 1  1  16644   2832   5500  71348    0    0   880   224 3714   320 20 36  0 45
 1  1  16644   3208   5380  71316    0    0   932     7 2879   412 20 28  0 52
 0  1  16644   3280   5356  71172    0    0   924     0 2828   348 22 27  0 51
 1  0  16644   3748   5368  71728    0    0  1056     0 2867   343 17 30  0 53
[steven@spc steven]$ free
             total       used       free     shared    buffers     cached
Mem:        386472     384032       2440          0       3936     113748
-/+ buffers/cache:     266348     120124
Swap:      1067928      16644    1051284


> 
> Andrea: have you tested under low memory and high fs load? Steven has 384M
> or RAM, which _will_ cause a lot of VM activity when doing a full kernel
> BK clone + undo + pull, which is what his test script ends up doing...
> 
> It would be good to test going back to the kernel that saw the "immediate 
> problem", and try that version without CONFIG_PREEMPT. 
> 
> 		Linus
> 
> 
I'll give that a try tomorrow.  I'll let this thing (sans PREEMPT and REGPARM) cook
on Andy's script overnight.  The kernel is up to date through Changeset 1.1724.

The original problem happened only about 20% of the time during bk pulls.
Prior to 4/15/04 (or perhaps a day or two before at most), it never happened.
The 'it' being the 'Assertion `s && s->tree' failed' during a bk pull.

Steven
