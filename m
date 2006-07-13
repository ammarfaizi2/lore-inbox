Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbWGMXA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbWGMXA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWGMXA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:00:29 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46752 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161034AbWGMXA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:00:28 -0400
Date: Thu, 13 Jul 2006 16:00:18 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       achirica@users.sourceforge.net, "David C. Hansen" <haveblue@us.ibm.com>,
       serue@us.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: airo.c
Message-ID: <20060713230018.GA24359@us.ibm.com>
References: <20060713205319.GA23594@us.ibm.com> <20060713212824.GA14729@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713212824.GA14729@infradead.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig [hch@infradead.org] wrote:
| On Thu, Jul 13, 2006 at 01:53:19PM -0700, Sukadev Bhattiprolu wrote:
| > Andrew,
| > 
| > Javier Achirica, one of the major contributors to drivers/net/wireless/airo.c
| > took a look at this patch, and doesn't have any problems with it. It doesn't
| > fix any bugs and is just a cleanup, so it certainly isn't a candidate
| > for this mainline cycle
| 
| I'm not sure it's that easy.  I think it needs some more love:
| 
|  - switch to wake_uo_process
|  - kill JOB_DIE
|  - cleanup a the convoluted mess in airo_thread a bit
| 
| Note that it's still reimplementing the single threaded workqueue
| functionality quite badly.  So if someone could switch it over and while
| we're at it try to kill the idiociy of doing the trylock in the calling
| context and only then calling the thread by always calling the thread
| (which also solves the synchronization problem).
| 
| Anywhy, here's a small incremental patch ontop of yours to implement my
| above items:

I had a quick look at your patch and looks fine to me. I agree we could
do more to clean up the driver.

My inital goal was to  replace kernel_thread() with kthread_*(). So can I
assume you are ok with my patch and that it can go in as is ?

Suka
