Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135364AbRDLWVr>; Thu, 12 Apr 2001 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135366AbRDLWVm>; Thu, 12 Apr 2001 18:21:42 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:10918 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135364AbRDLWVF>; Thu, 12 Apr 2001 18:21:05 -0400
Message-ID: <3AD62A18.8AC75605@mvista.com>
Date: Thu, 12 Apr 2001 15:20:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bret Indrelee <bret@io.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <Pine.LNX.4.21.0104121606360.10006-100000@fnord.io.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Indrelee wrote:
> 
> On Thu, 12 Apr 2001, george anzinger wrote:
> > Bret Indrelee wrote:
> > > Keep all timers in a sorted double-linked list. Do the insert
> > > intelligently, adding it from the back or front of the list depending on
> > > where it is in relation to existing entries.
> >
> > I think this is too slow, especially for a busy system, but there are
> > solutions...
> 
> It is better than the current solution.

Uh, where are we talking about.  The current time list insert is real
close to O(1) and never more than O(5).
> 
> The insert takes the most time, having to scan through the list. If you
> had to scan the whole list it would be O(n) with a simple linked list. If
> you insert it from the end, it is almost always going to be less than
> that.

Right, but compared to the current O(5) max, this is just too long.
> 
> The time to remove is O(1).
> 
> Fetching the first element from the list is also O(1), but you may have to
> fetch several items that have all expired. Here you could do something
> clever. Just make sure it is O(1) to determine if the list is empty.
> 
I would hope to move expired timers to another list or just process
them.  In any case they should not be a problem here.

One of the posts that started all this mentioned a tick less system (on
a 360 I think) that used the current time list.  They had to scan
forward in time to find the next event and easy 10 ms was a new list to
look at.  Conclusion: The current list structure is NOT organized for
tick less time keeping.

George
