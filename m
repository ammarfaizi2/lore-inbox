Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752005AbWJMXsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWJMXsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJMXsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:48:37 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:18353 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1752005AbWJMXsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:48:36 -0400
Date: Fri, 13 Oct 2006 16:47:45 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       John Richard Moser <nigelenki@comcast.net>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
In-Reply-To: <20061013233238.GA6038@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.63.0610131636560.10624@qynat.qvtvafvgr.pbz>
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com> 
 <452EA441.6070703@comcast.net> <452EA700.9060009@goop.org>
 <20061013233238.GA6038@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006, Andreas Mohr wrote:

> OK, so since we've now amply worked out in this thread that TLB/cache flushing
> is a real problem for context switching management, would it be possible to
> smartly reorder processes on the runqueue (probably works best with many active
> processes with the same/similar priority on the runqueue!) to minimize
> TLB flushing needs due to less mm context differences of adjacently scheduled
> processes?
> (i.e. don't immediately switch from user process 1 to user process 2 and
> back to 1 again, but always try to sort some kernel threads in between
> to avoid excessive TLB flushing)

since kernel threads don't cause flushing it shouldn't matter where they appear 
in the scheduleing.

other then kernel threads, only threaded programs share the mm context (in 
normal situations), and it would be a fair bit of work to sort the list of 
potential things to be scheduled to group these togeather (not to mention the 
potential fairness issues that would arise from this).

I suspect that the overhead of doing this sorting (and looking up the mm context 
to do the sorting) would overwelm the relativly small number of TLB flushes that 
would be saved.

I could see this being a potential advantage for servers with massive numbers of 
threads for one program, but someone would have to look at how much overhead the 
sorting would be (not to mention the fact that the kernel devs tend to frown on 
special case optimizations that have a noticable impact on the general case)

David Lang
