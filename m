Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135292AbRDWPVX>; Mon, 23 Apr 2001 11:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDWPVO>; Mon, 23 Apr 2001 11:21:14 -0400
Received: from cs1-hq.oecd.org ([193.51.65.66]:46091 "EHLO cs1-hq.oecd.org")
	by vger.kernel.org with ESMTP id <S135292AbRDWPVG>;
	Mon, 23 Apr 2001 11:21:06 -0400
Date: Mon, 23 Apr 2001 17:20:35 +0200
From: =?iso-8859-1?Q?R=EDkhar=F0ur_Egilsson?= 
	<Rikhardur.EGILSSON@oecd.org>
To: linux-kernel@vger.kernel.org
Subject: [2.2.19 reiserfs] vs-8345: get_mem_for_virtual_node: kmalloc failed.
Message-ID: <20010423172035.A4359@OECD.OECD.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Q: Why pay for drugs when you can get Linux for free ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine is has a 400MHz PII, Adaptec AIC-7895, 631 MB of memory,
and about 512 Meg of swap).

When compiling the kernel (2.2.19) I changed __FD_SETSIZE in
/usr/include/bits/types.h from 1024 to 8192.
(Increased number of file descriptors)

The following is executed at boot time:

# More file descriptors
echo 8192 > /proc/sys/fs/file-max

# Inodes 4x the file-max
echo 32768 > /proc/sys/fs/inode-max
# More user ports
echo 1024 32768 > /proc/sys/net/ipv4/ip_local_port_range

echo 768 > /proc/sys/net/ipv4/tcp_max_syn_backlog

echo 120 >  /proc/sys/net/ipv4/tcp_fin_timeout


And I started to see this recenty : 

Apr 19 11:54:24 netcache2 kernel: eth0: Memory squeeze, deferring packet.
Apr 19 11:54:24 netcache2 kernel: eth0: Memory squeeze, deferring packet.
Apr 19 11:54:33 netcache2 last message repeated 1113 times
Apr 19 11:54:33 netcache2 kernel: mem_for_virtual_node: kmalloc failed.  There were 272 allocations
Apr 19 11:54:33 netcache2 last message repeated 1113 times
Apr 19 11:54:33 netcache2 kernel: mem_for_virtual_node: kmalloc failed.  There were 272 allocations
Apr 19 11:54:33 netcache2 kernel: vs-8345: get_mem_for_virtual_node: kmalloc failed.  There were 272 allocations
Apr 19 11:54:33 netcache2 kernel: vs-8345: get_mem_for_virtual_node: kmalloc failed.  There were 272 allocations

...
...
This goes on until ...

Apr 19 11:56:45 netcache2 kernel: vs-8345: get_mem_for_virtual_node: kmalloc failed.  There were 272 allocations
Apr 19 11:56:45 netcache2 last message repeated 198 times
Apr 19 11:56:53 netcache2 squid[8377]: Squid Parent: child process 8439 exited due to signal 6
Apr 19 11:56:45 netcache2 last message repeated 198 times
Apr 19 11:56:53 netcache2 squid[8377]: Squid Parent: child process 8439 exited due to signal 6
Apr 19 11:56:56 netcache2 squid[8377]: Squid Parent: child process 13195 started
Apr 19 11:56:56 netcache2 squid[8377]: Squid Parent: child process 13195 started


Is there anything I can do to prevent this from happening ?

This (squid) server, serves about 50 requests/sec, so 2 minutes of downtime
means a lot of unhappy "customers". 


-- 
 Ríkharður Egilsson - Networking/Security EXD/ITN/CCO
 OECD/OCDE - Organisation for Economic Co-operation and Development
