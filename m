Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267203AbUBMXmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267210AbUBMXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:42:00 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:62220 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267203AbUBMXly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:41:54 -0500
Message-ID: <402D6262.90301@techsource.com>
Date: Fri, 13 Feb 2004 18:48:50 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Balaji Calidas <balaji@techsource.com>
Subject: Getting lousy NFS + tar-pipe throughput on 2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a fresh install of RH9 (kernel 2.4.20-something) on a 
workstation.  The workstation is an Athlon 3200+ with 512 megs of RAM on 
an ABIT KV7 (KT600 chipset).  The ethernet controller built into the KV7 
is "VIA RhineII".  The file system is ext3.


We are mounting an NFS filesystem from a Sun box using automount, and 
we're using a tar-pipe to move data from the server to the workstation. 
  Both tars of the tar-pipe are running on the workstation, so the 
network traffic is all NFS.

(1) We have verified that the disk load on the server is very low.  The 
disk is not being saturated.

(2) We have verified that the ethernet on the server is not being saturated.

(3) The workstation is connected to the server through a switch, so it's 
not competing for bandwidth with anything else.


In theory, we should get about 10 megabytes/sec throughput, but what 
we're measuring is about 1 to 2 megs/sec.


The workstation is using a single 120 gig WD IDE drive (WD1200JB), which 
as I was talking about in other emails should be able to do up to 30 
megs/sec for writes.


While this tar-pipe is going on, the workstation is very unresponsive. 
"top" reports that kernel CPU usage is anywhere from 30% to 70%, but 
mostly around 40%.  User space is using about 10%; that varies also. 
Despite the fact that there is some amount of idle time, the X cursor 
jumps about badly.

We're not compressing or anything.  We're just doing the tar-pipe. 
Therefore, the workstation should be experiencing very little load while 
it transfers a mere 10 megs/sec to disk.  Buffering in RAM should also 
allow the kernel to order writes efficiently.

Since the source tar process is talking to an NFS volume, the overhead 
of opening, reading, and closing small files could hurt throughput 
(would have been better to rsh the source tar so that the tar data is 
what was going over ethernet through a single socket).  But that should 
_reduce_ the amount of I/O that is being accomplished, thereby reducing 
the work being done by the workstation.  It would just WAIT more.  It 
should not be unresponsive.


I would like to investigate this performance issue, but I don't know 
what tools I should run to investigate.  If anyone could please give me 
some tips on it, I would be most appreciative.

Thanks!

