Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270880AbTHLTnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTHLTnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 15:43:49 -0400
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:16118 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S270880AbTHLTns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 15:43:48 -0400
Message-ID: <3F3943B9.7080700@vgertech.com>
Date: Tue, 12 Aug 2003 20:44:57 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Ken Savage <kens1835@shaw.ca>
CC: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High CPU load with kswapd and heavy disk I/O
References: <200308121136.11979.kens1835@shaw.ca>
In-Reply-To: <200308121136.11979.kens1835@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ken Savage wrote:
> Short version:
> ----------------
> kernels 2.4.17 --> 2.4.21
> Dual Athlon SMP system
> 4GB RAM, 2GB swap
> 3ware RAID, filled with millions of files across thousands of directories.
> reiserfs 3.6
> 
> The following command is guaranteed to lock out the box by activating
> kswapd to >95% CPU, blocking out pings, everything.
> 
>     find /RAID/data/ -type f -mtime +180 | xargs rm
> 

Can you send before, during and after:
cat /proc/meminfo
cat /proc/slabinfo

And maybe:
vmstat 1

Real kernel hackers (not me...) will find that information very usefull ;)

Regards,
Nuno Silva


> Details:
> ----------
> Applying the rmap patch seems to prevent kswapd from hogging the CPU,
> but causes it to freeze up for some other reason.  (The server is remote,
> so I can't view the console.)  Likewise 2.6.0-test* causes freezeups.
> Mind you, the server is under a fair bit of CPU and disk load -- hundreds
> of processes/threads all actively running.  I suspect something in rmap
> has made its way into 2.6 and our usage pattern is triggering the same
> fault in both places.
> 
> It appears as though the system is unable to efficiently clean up disk
> buffer memory when called on to do so.  In the Documentation/, there
> is mention of a buffermem sysctl, but that's nowhere to be found.
> It's obviously been removed/replaced...  Is there any way to limit the
> amount of buffer memory used by the system, that way if/when kswapd
> needs to reclaim it, there's very little work for it to do?
> 
> Admittedly, that's just masking the problem, as opposed to solving it.
> Any idea why kswapd is having such a tough go??  Known solutions
> for this problem?
> 
> TIA,
> 
> Ken
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

