Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUFPLX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUFPLX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUFPLX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:23:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:6795 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266243AbUFPLXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:23:25 -0400
Date: Wed, 16 Jun 2004 13:19:12 +0200
From: Andi Kleen <ak@suse.de>
To: johnstul@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux@brodo.de
Subject: lost timer check in 2.6.7
Message-Id: <20040616131912.14b73b39.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.7 has 

+               /* ... but give the TSC a fair chance */
+               if (lost_count > 25)
+                       cpufreq_delayed_get();

While looking at porting this code to x86-64 I noticed that this only runs for 
the first lost timer event. In case of dynamic frequency which varies shouldn't this
be more like

		if ((lost_count % 25) == 0) 
			cpufreq_delayed_get();

? Otherwise this heuristic will only work once.

-Andi
