Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266588AbUBDU4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266597AbUBDUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:54:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:26028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266588AbUBDUxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:53:19 -0500
Date: Wed, 4 Feb 2004 12:54:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
Message-Id: <20040204125444.3f2b5e79.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
	<Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
>
> 
> I am still experiencing severely degraded network performance under
> 2.6.2-rc3 and 2.6.2-rc3-mm1.

A kernel profile is needed.

>  Based on some kernel output, I think this
> problem may be related to Gerd Knorr's input patches, so I am CCing him on
> this e-mail.

Sounds unlikely.

> Additionally, while large network transfers are going on, both ksoftirqd/0
> and events/0 start going crazy, putting a huge load on my system:
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   3 root      35  19     0    0    0 S 45.9  0.0   0:46.98 ksoftirqd/0
>   6 root       5 -10     0    0    0 S 43.3  0.0   1:56.63 events/0
>   12008 dogshu 15   0  4800 2356 3828 S  5.3  0.2   0:05.98 proftpd
>   12 root      15   0     0    0    0 S  0.3  0.0   0:00.41 pdflush
>   9778 root    16   0  5888 1724 5516 R  0.3  0.2   0:00.12 sshd
> 
> the load before that network transfer was 0.01, and the load after the
> network transfer was 1.45.

Could be a networking problem, but boy that's a lot of CPU time.


Please, do this:

- Boot with `profile=1' on the kernel command line

sudo readprofile -r
sudo readprofile -M10
time <whatever command it is that is causing the problem>
readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40 | tee ~/log

Making very sure that /boot/System.map is the correct map file for the
currently-running kernel.

Thanks.
