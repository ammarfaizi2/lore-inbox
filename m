Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274991AbRJJGu6>; Wed, 10 Oct 2001 02:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJJGus>; Wed, 10 Oct 2001 02:50:48 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38791 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274989AbRJJGuc>; Wed, 10 Oct 2001 02:50:32 -0400
Date: Wed, 10 Oct 2001 12:24:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010122400.A17006@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <Pine.LNX.4.33.0110092236210.1305-100000@penguin.transmeta.com> Linus Torvalds wrote:

> Now, in all fairness I can imagine hacky lock-less removals too. To get
> them to work, you have to (a) change the "next" pointer to point to the
> next->next (and have some serialization between removals, but removals
> only, to make sure you don't have next->next also going away from you) and
> (b) leave the old "next" pointer (and thus the data structure) around
> until you can _prove_ that nobody is looking anything up any more, and
> that the now-defunct data structure can truly be removed.

This is exactly what Read-Copy Update does. You keep the old data
structure around until you are sure that all the CPUs have lost
references to it by context switching. There are more than
one relatively non-intrusive ways of detecting completion of such a cycle
and "deleted" data can be freed afterwards.

The details are in http://lse.sourceforge.net/locking/rcupdate.html.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
