Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTE0D3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTE0D3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:29:02 -0400
Received: from adsl-67-122-203-155.dsl.pltn13.pacbell.net ([67.122.203.155]:29610
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S263056AbTE0D3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:29:01 -0400
Message-ID: <3ED2DE86.2070406@storadinc.com>
Date: Mon, 26 May 2003 20:41:58 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, manish <manish@storadinc.com>
Subject: 2.4.20: Proccess stuck in __lock_page ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I am running the 2.4.20 kernel on a system with 3.5 GB RAM and dual CPU. 
I am running bonnie accross four drives in parallel:

bonnie -s 1000 -d /<dir-name>

bdflush settings on this system:

[root@dyn-10-123-130-235 vm]# cat bdflush
2       50      32      100     50      300     1       0       0

All the bonnie process and any other process (like df, ps -ef etc.) are 
hung in __lock_page. Breaking into kdb, I observe the following for one 
such bonnie process:

schedule(..)
__lock_page(..)
lock_page(..)
do_generic_file_read(..)
generic_file_read(..)

After this, the processes never exit the hang. At times, a couple of 
bonnie processes complete but the hang still occurs with the remaining 
processes and with the other processes.

I tried out the 2.5.33 kernel (one of the 2.5 series) and observed that 
the hang does not occur. If I run, two bonnie processes, they never get 
stuck. Actually, if I run 4 parallel mke2fs, they too get stuck.

Any clues where this could be happening?

Thanks
-Manish

