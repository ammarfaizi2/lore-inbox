Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVLUGJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVLUGJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVLUGJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:09:17 -0500
Received: from pat.uio.no ([129.240.130.16]:58873 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932277AbVLUGJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:09:17 -0500
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on
	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43A8EF87.1080108@bigpond.net.au>
References: <43A8EF87.1080108@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 01:09:01 -0500
Message-Id: <1135145341.7910.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.111, required 12,
	autolearn=disabled, AWL 1.70, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 17:00 +1100, Peter Williams wrote:
> This patch addresses the adverse effect that the NFS client can have on 
> interactive response when CPU bound tasks (such as a kernel build) 
> operate on files mounted via NFS.  (NB It is emphasized that this has 
> nothing to do with the effects of interactive tasks accessing NFS 
> mounted files themselves.)
> 
> The problem occurs because tasks accessing NFS mounted files for data 
> can undergo quite a lot of TASK_INTERRUPTIBLE sleep depending on the 
> load on the server and the quality of the network connection.  This can 
> result in these tasks getting quite high values for sleep_avg and 
> consequently a large priority bonus.  On the system where I noticed this 
> problem they were getting the full 10 bonus points and being given the 
> same dynamic priority as genuine interactive tasks such as the X server 
> and rythmbox.
> 
> The solution to this problem is to use TASK_NONINTERACTIVE to tell the 
> scheduler that the TASK_INTERRUPTIBLE sleeps in the NFS client and 
> SUNRPC are NOT interactive sleeps.

Sorry. That theory is just plain wrong. ALL of those case _ARE_
interactive sleeps.

Cheers,
  Trond

