Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWCNHcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWCNHcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWCNHcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:32:20 -0500
Received: from duke.cs.duke.edu ([152.3.140.1]:42239 "EHLO duke.cs.duke.edu")
	by vger.kernel.org with ESMTP id S932076AbWCNHcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:32:19 -0500
Date: Tue, 14 Mar 2006 02:32:17 -0500 (EST)
From: Tong Li <tongli@cs.duke.edu>
To: linux-kernel@vger.kernel.org
Subject: Bursty I/O in ext3
Message-ID: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernbench (make -j 128 on a kernel source) back to back 
multiple times on an SMP. Among every 10 runs, there's always at least one 
run that has a run time around 40% longer than the other runs. (Before 
kernbench starts timing, it does a sync.) 'vmstat 1' indicates that the 
longer runs always have a couple of 1-sec intervals during which there are 
10 times more block-outs (bo field) than the average traffic in the rest 
of the run, and during these intervals, many cc1 processes are in the D 
state. My file system is ext3 and all the things like journal commit 
interval, pdflush interval, etc. have the default values.

I'm trying to understand why such variability occurs. I tested the same 
thing with ext2 and did not see any variability. So I'm thinking about two 
things: (1) for some reason, ext3/jbd occasionally issues a large volume 
of bursty writes to the disk (but why does it occur just sometimes, not 
always?), and (2) when there are bursty writes, the block device driver is 
not able to handle them, causing I/O waits. But I don't really have a 
clear understanding of the problem here...

Does anyone have any insight on this, or any suggestion on how to figure 
it out?

Thanks,

   tong

PS. I'm not subscribed to the list, so please cc me.
