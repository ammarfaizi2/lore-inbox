Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVAPEL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVAPEL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVAPELz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:11:55 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:64441 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262415AbVAPELp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:11:45 -0500
Message-ID: <41E9E97F.6090806@yahoo.com.au>
Date: Sun, 16 Jan 2005 15:11:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: aeriksson@fastmail.fm
CC: linux-kernel@vger.kernel.org
Subject: Re: kswapd (& clock?) problems in 2.6.10
References: <20050115134052.7CD3A24286B@latitude.mynet.no-ip.org>
In-Reply-To: <20050115134052.7CD3A24286B@latitude.mynet.no-ip.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aeriksson@fastmail.fm wrote:
> Since installing 2.6.10 kswapd has decided to loop wildly on two
> occations. Both occations happened after starting a big compiles.
> Checking vmstat, I noticed a steady stream of io/bi figures ranging
> between 2-5K (which is about what I can get out of this box during
> normal operation), but no swap io(?). Manwhile the load (xload)climbs
> to about 10, and the system looses interactive responsiveness.
> 
> Now after the last time, after reboot, I noticed that the clock was
> missing 3 hours, which is about the time I left the box unattended. It
> might be that kswapd stresses the system to the point that the clock
> cannot move forward, (or the clock does something bad and kswapd gets
> tricked by it???).
> 
> Thoughts anyone?
> 

Are you sure it is a bug? kswapd has been recently fixed so it properly
starts freeing memory before the critical shortage is reached where
processes have to synchronously free memory for themselves.

This will make kswapd take more CPU time, but it should be doing work
that would otherwise need to be done by someone else. The lack of any
swapping activity indicates that kswapd is not actually having too much
trouble freeing memory (or you have swap turned off!)

If you still think it is a bug, if kswapd keeps running after the compile
stops, or if the system stops doing useful work, then let's see what the
problem is:

Can you make sure you kernel is compiled with "magic sysrq key" turned
on (under kernel hacking menu). While the weird kswapd behaviour happens
next, press alt+sysrq+m 3 or 4 times, then dump dmesg to a file
`dmesg > dmesg.out`, and send that file in.

Thanks,
Nick

