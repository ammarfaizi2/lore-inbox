Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVFUFVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVFUFVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVFUFT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:19:26 -0400
Received: from dvhart.com ([64.146.134.43]:26289 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261635AbVFUFH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 01:07:29 -0400
Date: Mon, 20 Jun 2005 22:07:34 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <208690000.1119330454@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, after fixing the build failure with Andy's patch here:

http://mbligh.org/abat/apw_pci_assign_unassigned_resources

I get a boot failure on the NUMA-Q box. Full log is here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/6184/debug/console.log

But at the end it prints out lots of wierd scheduler stuff, then one more
message, then dies:

| migration cost matrix (max_cache_size: 2097152, cpu: 700 MHz):
---------------------
          [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]    [08]    [09]    [10]    [11]    [12]    [13]    [14]    [15]
[00]:     -    12.0(0) 12.0(0) 12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[01]:  12.0(0)    -    12.0(0) 12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[02]:  12.0(0) 12.0(0)    -    12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[03]:  12.0(0) 12.0(0) 12.0(0)    -    466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[04]:  466.0(1) 466.0(1) 466.0(1) 466.0(1)    -    12.0(0) 12.0(0) 12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[05]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0)    -    12.0(0) 12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[06]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0) 12.0(0)    -    12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[07]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0) 12.0(0) 12.0(0)    -    466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[08]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)    -    12.0(0) 12.0(0) 12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[09]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0)    -    12.0(0) 12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[10]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0) 12.0(0)    -    12.0(0) 466.0(1) 466.0(1) 466.0(1) 466.0(1)
[11]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0) 12.0(0) 12.0(0)    -    466.0(1) 466.0(1) 466.0(1) 466.0(1)
[12]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1)    -    12.0(0) 12.0(0) 12.0(0)
[13]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0)    -    12.0(0) 12.0(0)
[14]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0) 12.0(0)    -    12.0(0)
[15]:  466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 466.0(1) 12.0(0) 12.0(0) 12.0(0)    -   
--------------------------------
| cacheflush times [2]: 12.0 (12000000) 466.0 (466000000)
| calibration delay: 29 seconds
--------------------------------
NET: Registered protocol family 16


I guess I'll try backing out the scheduler patches unless someone else 
has a brighter idea?

M.

