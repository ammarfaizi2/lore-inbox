Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTFDVea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTFDVea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:34:30 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:24411 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264124AbTFDVe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:34:29 -0400
Message-ID: <3EDE68F8.7DF2D0AC@digeo.com>
Date: Wed, 04 Jun 2003 14:47:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.70-mm3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mm3 hang
References: <1274420000.1054758735@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 21:47:59.0651 (UTC) FILETIME=[F74D2730:01C32AE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> SDET hangs it every few runs.
> 

You have a large number of `ps' instances which appear to be
stuck on /proc's i_sem and lots of processes stuck in
sched_balance_exec->set_cpus_allowed->wait_for_completion.

The latter is a NUMA-special.  You might want to examine the
sched_best_cpu() fixes carefully.  Also see whether 2.5.70+bk
does the same thing.
