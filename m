Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSHIPct>; Fri, 9 Aug 2002 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSHIPct>; Fri, 9 Aug 2002 11:32:49 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:9299 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S314077AbSHIPcs>;
	Fri, 9 Aug 2002 11:32:48 -0400
Date: Fri, 9 Aug 2002 17:36:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       andrea@suse.de, gh@us.ibm.com
Subject: Re: Analysis for Linux-2.5 fix/improve get_pid(), comparing various approaches
Message-ID: <20020809153615.GA1062@win.tue.nl>
References: <1028757835.22405.300.camel@plars.austin.ibm.com> <3D51A7DD.A4F7C5E4@zip.com.au> <20020808002419.GA528@win.tue.nl> <200208090722.08223.frankeh@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208090722.08223.frankeh@watson.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 07:22:08AM -0400, Hubertus Franke wrote:

> Particulary for large number of tasks, this can lead to frequent exercise of
> the repeat resulting in a O(N^2) algorithm. We call this : <algo-0>.

Your math is flawed. The O(N^2) happens only when the name space for pid's
has the same order of magnitude as the number N of processes.
Now consider N=100000 with 31-bit name space. In a series of
2.10^9 forks you have to do the loop fewer than N times and
N^2 / 2.10^9 = 5. You see that on average for each fork there
are 5 comparisons.
For N=1000000 you rearrange the task list as I described yesterday
so that each loop takes time sqrt(N), and altogether N.sqrt(N)
comparisons are needed in a series of 2.10^9 forks.
That is 0.5 comparisons per fork.

You see that thanks to the large pid space things get really
efficient. Ugly constructions are only needed when a large fraction
of all possible pids is actually in use, or when you need hard
real time guarantees.

Andries
