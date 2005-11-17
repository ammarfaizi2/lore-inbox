Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVKQQmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVKQQmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVKQQmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:42:42 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:35561 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S932414AbVKQQmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:42:42 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <0B4DF355-7EC7-4B4E-8869-44349F436624@garrett.co.uk>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Russell Garrett <russ@garrett.co.uk>
Subject: Strange memory usage with Opteron/NUMA
Date: Thu, 17 Nov 2005 16:42:36 +0000
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have several dual-Opteron/8GB RAM systems, all of which run an  
application (MySQL) which allocates a fixed block of 6.5GB of RAM,  
and looking at ps confirms this. However, when running the kernel  
(2.6.14.2) with the K8_NUMA option enabled, 2GB of swap is used (on  
top of the 6.5GB of physical memory), although the process only  
claims to be using 6.5GB in total. Additionally, the kernel is  
definitely swapping this imaginary memory in and out.

Switching the K8_NUMA option off eliminates this.

Here is an example ps line:

mysql     2395  3.5 85.1 7296648 6921696 ?   S    Nov15 101:03 /usr/ 
local/mysql/bin/mysqld --basedir=/usr/local/mysql --datad

And the associated /proc/meminfo contents:

MemTotal:      8126276 kB
MemFree:         27664 kB
Buffers:          3644 kB
Cached:        1042952 kB
SwapCached:    2681912 kB
Active:        6938484 kB
Inactive:      1051096 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      8126276 kB
LowFree:         27664 kB
SwapTotal:     5831552 kB
SwapFree:      2915596 kB
Dirty:             896 kB
Writeback:         664 kB
Mapped:        6929904 kB
Slab:            80720 kB
CommitLimit:   9894688 kB
Committed_AS:  7352452 kB
PageTables:      14592 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      3312 kB
VmallocChunk: 34359734971 kB

Thanks in advance,

Russ Garrett
russ@last.fm
