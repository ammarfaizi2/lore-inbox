Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267825AbUIBIBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267825AbUIBIBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUIBIBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:01:40 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:21924 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S267825AbUIBH5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:57:13 -0400
X-Mailer: Openwave WebEngine, version 2.8.10 (webedge20-101-191-20030113)
X-Originating-IP: [62.236.163.232]
From: <mika.penttila@kolumbus.fi>
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Date: Thu, 2 Sep 2004 10:57:12 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20040902075712.DGPM28426.fep02-app.kolumbus.fi@mta.imail.kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I think there might be a problem with voluntary-preempt's hadling of softirqs. Namely, in cond_resched_softirq(), you do __local_bh_enable() and local_bh_disable(). But it may be the case that the softirq is handled from ksoftirqd, and then the preempt_count isn't elevated with SOFTIRQ_OFFSET (only PF_SOFTIRQ is set). So the __local_bh_enable() actually makes preempt_count negative, which might have bad effects. Or am I missing something?

Mika


