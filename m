Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967870AbWK3UnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967870AbWK3UnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967865AbWK3UnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:43:06 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:41454 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S967175AbWK3UnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:43:03 -0500
Date: Thu, 30 Nov 2006 14:42:58 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: RE: [patch 1/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <20061130.121443.116355312.davem@davemloft.net>
To: David Miller <davem@davemloft.net>, johnpol@2ka.mipt.ru
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGIEANCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It steals timeslices from other processes to complete tcp_recvmsg()
> task, and only when it does it for too long, it will be preempted.
> Processing backlog queue on behalf of need_resched() will break
> fairness too - processing itself can take a lot of time, so process
> can be scheduled away in that part too.

It does steal timeslices from other processes to complete tcp_recvmsg()
task. But I do not think it will  take long. When processing backlog, the
processed packets will go to the receive buffer, the TCP flow control will
take effect to slow down the sender.


The data receiving process might be preempted by higher priority processes.
Only the data recieving process stays in the active array, the problem is
not that bad because the process might resume its execution soon. The worst
case is that it expires and is moved to the active array with packets within
the backlog queue.


wenji


