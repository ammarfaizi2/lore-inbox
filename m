Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVG1VfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVG1VfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVG1VfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:35:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261526AbVG1VdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:33:06 -0400
Date: Thu, 28 Jul 2005 23:32:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
Message-ID: <20050728213254.GA1844@elf.ucw.cz>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net> <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz> <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz> <Pine.LNX.4.62.0507281251040.12675@graphe.net> <Pine.LNX.4.62.0507281254380.12781@graphe.net> <20050728212715.GA2783@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728212715.GA2783@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Introduce a todo notifier in the task_struct so that a task can be told to do
> > certain things. Abuse the suspend hooks try_to_freeze, freezing and refrigerator
> > to establish checkpoints where the todo list is processed. This will break software
> > suspend (next patch fixes and cleans up software suspend).
> 
> Ugh, this conflicts with stuff in -mm tree rather badly... In part
> thanks to patch by you that was already applied.
> 
> I fixed up rejects manually (but probably lost fix or two in
> progress), and will test.
> 
> Uff, and then it breaks suspend completely:
> 
> Jul 28 23:21:12 amd kernel: Stopping tasks:
> =====================================Restarting tasks...khpsbpkt:
> received unexpected signal?!
> Jul 28 23:21:12 amd kernel: NodeMgr: received unexpected signal?!
> Jul 28 23:21:22 amd kernel:  done
> Jul 28 23:21:32 amd pam_limits[1547]: wrong limit value 'unlimited'
> 
> (Left me with basically all kernel threads going crazy:)
> 
> top - 23:22:34 up 3 min,  4 users,  load average: 5.10, 1.90, 0.69
> Tasks:  48 total,   2 running,  46 sleeping,   0 stopped,   0 zombie
> Cpu(s):  0.0% us, 100.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
> 0.0% si
> Mem:   2064480k total,   155664k used,  1908816k free,    10280k
> buffers
> Swap:  2136448k total,        0k used,  2136448k free,   114624k
> cached
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   273 root      25   0     0    0    0 S 21.1  0.0   0:11.24 kswapd0
>   938 root      25   0     0    0    0 S 21.1  0.0   0:11.24 pccardd
>   940 root      25   0     0    0    0 S 21.1  0.0   0:11.30 pccardd
>  1060 root      25   0     0    0    0 R 21.1  0.0   0:21.34 kjournald
>  1409 root      25   0     0    0    0 S 17.3  0.0   0:19.71 kjournald
> 
> You are doing rather intrusive changes. Is testing them too much to
> ask? I'm pretty sure you can get i386 machine to test swsusp on...

(And yes, I did apply the whole series. It would be nice if next
series was relative to -mm, it already contains some of your changes).

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
