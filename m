Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275913AbSIUOKI>; Sat, 21 Sep 2002 10:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275914AbSIUOKI>; Sat, 21 Sep 2002 10:10:08 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:54235 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S275913AbSIUOKH>;
	Sat, 21 Sep 2002 10:10:07 -0400
Message-ID: <3D8C7EEE.7030500@colorfullife.com>
Date: Sat, 21 Sep 2002 16:15:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: quadratic behaviour
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me repeat this, and call it an observation instead of a question,
> so that you do not think I am in doubt.
> 
> If you have 20000 processes, and do ps, then get_pid_list() will be
> called 1000 times, and the for_each_process() loop will examine
> 10000000 processes.
> 
> Unlike the get_pid() situation, which was actually amortized linear with a very
> small coefficient, here we have a bad quadratic behaviour, still in 2.5.37.
> 
One solution would be to replace the idtag hash with an idtag tree.

Then get_pid_list() could return an array of sorted pids, and finding 
the next pid after unlocking the task_lock would be just a tree lookup 
(find first pid larger than x).

And a sorted tree would make it possible find the next safe range for 
get_pid() with O(N) instead of O(N^2).

--
	Manfred


