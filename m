Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUBLHok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBLHok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:44:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:11465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266245AbUBLHoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:44:38 -0500
Date: Wed, 11 Feb 2004 23:44:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Florian Schanda <ma1flfs@bath.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 99% System load
Message-Id: <20040211234413.3d90df5d.akpm@osdl.org>
In-Reply-To: <200402111423.02217.ma1flfs@bath.ac.uk>
References: <200402111423.02217.ma1flfs@bath.ac.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schanda <ma1flfs@bath.ac.uk> wrote:
>
> Sometimes (not allways, thats the problem, otherwise I could just avoid the 
>  offending command) during paralel builds (for instance kde-libs or kde-base)
>  the build just stops, and I get a 99% system load.
> 
>  For instance, just now I have (from top):
> 
>  Tasks:  89 total,   5 running,  84 sleeping,   0 stopped,   0 zombie
>   Cpu0 :  0.3% us, 99.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
>   Cpu1 :  0.3% us, 99.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
>   Cpu2 :  1.3% us, 98.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
>   Cpu3 :  1.0% us, 99.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
>  Mem:   2071872k total,  1220772k used,   851100k free,    48080k buffers
>  Swap:   401616k total,        0k used,   401616k free,   892428k cached
> 
>    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   5197 ma1flfs   25   0  2256  884 2184 R 99.5  0.0   6:29.38 sh
>   5199 ma1flfs   25   0  2260  888 2184 R 99.5  0.0   6:28.02 sh
>   5201 ma1flfs   25   0  2260  884 2184 R 98.5  0.0   6:29.99 sh
>   5208 ma1flfs   25   0  1560  440 1404 R 98.5  0.0   6:32.03 grep

Make sure that you have enabled CONFIG_KALLSYMS, and that
/proc/sys/kernel/sysrq is set to one.  Then, when it hangs, do

	echo t > /proc/sysrq-trigger

or type alt-sysrq-t

Then, run

	dmesg -s 1000000 > /tmp/foo

and make `foo' available.

It would help if you could make a note of the PIDs of the hung processes,
so they can be correlated with the sysrq output.

Thanks.

