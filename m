Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSFRRus>; Tue, 18 Jun 2002 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317524AbSFRRur>; Tue, 18 Jun 2002 13:50:47 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:36326 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317522AbSFRRuq>; Tue, 18 Jun 2002 13:50:46 -0400
Message-ID: <3D0F72E2.3C854E4@nortelnetworks.com>
Date: Tue, 18 Jun 2002 13:50:26 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: David Schwartz <davids@webmaster.com>, rml@tech9.net, mgix@mgix.com,
       linux-kernel@vger.kernel.org
Subject: Re: Question about sched_yield()
References: <Pine.LNX.4.44L.0206181422460.12322-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 18 Jun 2002, Chris Friesen wrote:

> > However, if there is anything else other than the idle task that wants
> > to run, then it should run until it exhausts its timeslice.
> >
> > One process looping on sched_yield() and another one doing calculations
> > should result in almost the entire system being devoted to calculations.
> 
> So if you have a database with 20 threads yielding to each other
> each time a lock is contended and one CPU hog the database should
> be reduced to a very small percentage of the CPU ?

If the database threads are at a higher priority than the cpu hog, then no they
shouldn't.  The one that owns the lock should progress as normal.  Assuming that
only the thread owning the lock progresses, the cpu usage ratio between the
threads as a group and the hog should be roughly equivalent to a single database
thread and a single hog.

We certainly shouldn't thrash the yielding threads and starve the hog.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
