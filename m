Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVHaVQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVHaVQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVHaVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:16:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16017 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964966AbVHaVQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:16:39 -0400
Date: Wed, 31 Aug 2005 22:16:50 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050831211650.GD24383@gallifrey>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de> <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831142413.GB24383@gallifrey> <Pine.LNX.4.61.0508312039220.1081@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508312039220.1081@diagnostix.dwd.de>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3smp (i686)
X-Uptime: 22:12:25 up 139 days, 20:43, 46 users,  load average: 0.01, 0.01, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Holger Kiehl (Holger.Kiehl@dwd.de) wrote:

> There is however one difference, here I had set
> /sys/block/sd?/queue/nr_requests to 4096.

Well from that it looks like none of the queues get about 255
(hmm that's a round number....)

> avg-cpu:  %user   %nice    %sys %iowait   %idle
>            0.10    0.00   21.85   58.55   19.50

Fair amount of system time.

> Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s 
> avgrq-sz avgqu-sz   await  svctm  %util

> sdf        11314.90   0.00 365.10  0.00 93440.00    0.00 46720.00     0.00  
> 255.93     1.92    5.26   2.74  99.98
> sdg        7973.20   0.00 257.20  0.00 65843.20    0.00 32921.60     0.00   
> 256.00     1.94    7.53   3.89 100.01

There seems to be quite a spread of read performance accross the drives
(pretty consistent accross the run); what makes sdg so much slower than
sdf (which seems to be the slowest and fastest drives respectively).
I guess if everyone was running at sdf's speed you would be pretty happy.

If you physically swap f and g does the performance follow the drive
or the letter?

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
