Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWKGTWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWKGTWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWKGTWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:22:01 -0500
Received: from mga07.intel.com ([143.182.124.22]:18259 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750714AbWKGTWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:22:00 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,397,1157353200"; 
   d="scan'208"; a="142594770:sNHT17991771"
Subject: 2.6.19-rc1: Volanomark slowdown
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: linux-kernel@vger.kernel.org
Cc: davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru
Content-Type: text/plain
Organization: Intel
Date: Tue, 07 Nov 2006 10:32:34 -0800
Message-Id: <1162924354.10806.172.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch

[TCP]: Send ACKs each 2nd received segment
commit: 1ef9696c909060ccdae3ade245ca88692b49285b
http://kernel.org/git/?
p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1ef9696c909060ccdae3ade245ca88692b49285b

reduced Volanomark benchmark throughput by 10%.  
This is because Volanomark sends 
short message (<100 bytes) on its TCP
connections.  This patch increases the number of ACKs 
traffic by 3.5 times.  

By adopting this patch, we assume that with
small segment, having short delay is important 
enough that we are willing to reduce bandwidth 
with more ACKs.  

Is there any real application out there
that this new behavior could be a concern?

Tim 
