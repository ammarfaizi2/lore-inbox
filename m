Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264925AbUELKIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUELKIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 06:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUELKIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 06:08:20 -0400
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:10636 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S264931AbUELKIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 06:08:18 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Status field in ps output for threaded programs in 2.6 kernel
Date: Wed, 12 May 2004 14:07:22 +0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405121407.22551@zigzag.lvk.cs.msu.su>
X-Scanner: exiscan *1BNqe3-0006gG-00*TK.tP7PTrag*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Today I faced a situation that confused me.

One moment I found that on our server there is almost 100% CPU load in 
system state. However, ps and top and other tools could not locate any 
process eating CPU.

The situation was permanent - several minutes passed, still almost 100% CPU 
in system state, still no visible running processes.

I executed chkrootkit and it found lots of "hidden processes" - ones for 
which /proc/N/ exists (i.e. it is possible to cd there), but N is not in 
ps output (and even not in ls /proc output).

I checked /proc/N/cmdline for some of such "hidden" pids; it looks like 
they represent threads. 
Well, maybe it is how NPTL threads work: for each thread a hidden /proc 
entry exists.
And it is chkrootkit's problem that is reports this (normal) case as 
possible LKM installed.

However, in my case, CPU-eating entities were found among thise hidden 
pids! They belonged to the same process (locally developed app, probably 
hanged), and this process was listed in ps output with status "S". After 
process was killed, CPU load went to 0%.

Looks like kernel bug: displayed status of threaded process should not be 
"S" if some threads are active. And CPU usage statistics should correspond 
to all threads.

This happened on a Debian testing/unstable system, running kernel package 
kernel-image-2.6.5-1-k7-smp 2.6.5-4.
