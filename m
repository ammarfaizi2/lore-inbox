Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSHISMs>; Fri, 9 Aug 2002 14:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSHISMs>; Fri, 9 Aug 2002 14:12:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62718 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315275AbSHISMr>;
	Fri, 9 Aug 2002 14:12:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Analysis for Linux-2.5 fix/improve get_pid(), comparing various approaches
Date: Fri, 9 Aug 2002 14:14:58 -0400
User-Agent: KMail/1.4.1
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       andrea@suse.de, gh@us.ibm.com
References: <1028757835.22405.300.camel@plars.austin.ibm.com> <200208090722.08223.frankeh@watson.ibm.com> <20020809153615.GA1062@win.tue.nl>
In-Reply-To: <20020809153615.GA1062@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208091414.58353.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 11:36 am, Andries Brouwer wrote:

!!!!!!!!!!! You are in a different space !!!!!!!!
All work was done under the assumption of 16-bit pid_t.
I stated yesterday already that for NumTasks substantially smaller
than the pid_t supported size, this won't be a problem
as your analysis states and my data also states.

You have two choices 
(a) move Linux up to 32-bit pid_t
(b) stick within the current 16-bit discussion.

> On Fri, Aug 09, 2002 at 07:22:08AM -0400, Hubertus Franke wrote:
> > Particulary for large number of tasks, this can lead to frequent exercise
> > of the repeat resulting in a O(N^2) algorithm. We call this : <algo-0>.
>
> Your math is flawed. The O(N^2) happens only when the name space for pid's
> has the same order of magnitude as the number N of processes.
> Now consider N=100000 with 31-bit name space. In a series of
> 2.10^9 forks you have to do the loop fewer than N times and
> N^2 / 2.10^9 = 5. You see that on average for each fork there
> are 5 comparisons.
> For N=1000000 you rearrange the task list as I described yesterday
> so that each loop takes time sqrt(N), and altogether N.sqrt(N)
> comparisons are needed in a series of 2.10^9 forks.
> That is 0.5 comparisons per fork.
>
> You see that thanks to the large pid space things get really
> efficient. Ugly constructions are only needed when a large fraction
> of all possible pids is actually in use, or when you need hard
> real time guarantees.
>
> Andries


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
