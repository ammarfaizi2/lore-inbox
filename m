Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUDENOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUDENOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:14:51 -0400
Received: from pop.gmx.net ([213.165.64.20]:14019 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262365AbUDENOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:14:49 -0400
X-Authenticated: #12437197
Date: Mon, 5 Apr 2004 15:15:20 +0200
From: Dan Aloni <da-x@colinux.org>
To: Cooperative Linux Development 
	<colinux-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: coLinux benchmarks
Message-ID: <20040405131520.GA4395@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today I ran some dbench2 benchmarks in order to test coLinux's
(http://www.colinux.org) virtual disk I/O performance.

I'm cross-posting this message to the LKML, as I know that on that
list there are some benchmarking experts or other people who may 
find this interesting.

This is the output from a coLinux 2.4.25 guest VM configured with 
128MB RAM running on a Linux 2.6.3 (BK) host that has a total of 
256MB RAM. The host machine has a Mobile Intel Celeron CPU (2.20GHz). 
All filesystems used are ext3.

    colinux:/home/dax# dbench 5 -s -S
    5 clients started
       0     62477  10.01 MB/sec
    Throughput 10.0026 MB/sec (sync open) (sync dirs) 5 procs

    colinux:/home/dax# dbench 5 -s -S
    5 clients started
       0     62477  10.43 MB/sec
    Throughput 10.4262 MB/sec (sync open) (sync dirs) 5 procs

    colinux:/home/dax# dbench 5 -s -S
    5 clients started
       0     62477  10.90 MB/sec
    Throughput 10.8926 MB/sec (sync open) (sync dirs) 5 procs


I then ran the same thing on the host itself, *without* the 
coLinux VM running in the background:

    hostile17:~/colinux# dbench 5 -s -S
    5 clients started
       0     62477  5.08 MB/sec
    Throughput 5.07573 MB/sec (sync open) (sync dirs) 5 procs
    
    hostile17:~/colinux# dbench 5 -s -S
    5 clients started
       0     62477  5.13 MB/sec
    Throughput 5.12705 MB/sec (sync open) (sync dirs) 5 procs


The VM shows better results than the host. What gives? Perhaps
it is because of the combination of the host and guest's buffer 
cache? I'd like to know about more percise benchmarking methods 
for VMs.

-- 
Dan Aloni
Cooperative Linux, lead developer
da-x@colinux.org
