Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVBAFqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVBAFqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVBAFqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:46:42 -0500
Received: from fmr13.intel.com ([192.55.52.67]:30674 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261576AbVBAFqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:46:37 -0500
Subject: possible performance issue in 4-level page tables
From: Zou Nan hai <nanhai.zou@intel.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1107231570.2555.19.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 01 Feb 2005 12:19:30 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a performance regression of lmbench
lat_proc fork result on ia64.

in 
2.6.10 

I got 
Process fork+exit:164.8438 microseconds.

in 2.6.11-rc2
Process fork+exit:183.8621 microseconds.

I believe this regression was caused by 
the 4-level page tables change.

Since most of the kernel time spend in lat_proc fork is copy_page_range
in fork path and clear_page_range in the exit path. Now they are 1 level
deeper.

Though pud and pgd is same on IA64, there is still some overhead
introduced I think.
 
Are any other architectures seeing the same sort of results?

Zou Nan hai

