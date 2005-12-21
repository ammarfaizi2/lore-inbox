Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVLUNlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVLUNlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVLUNlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:41:16 -0500
Received: from pat.uio.no ([129.240.130.16]:43252 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932416AbVLUNlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:41:15 -0500
Subject: Re: [PATCH] sched: Fix adverse effects of NFS
	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 08:40:53 -0500
Message-Id: <1135172453.7958.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.995, required 12,
	autolearn=disabled, AWL 1.82, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 08:36 -0500, Kyle Moffett wrote:
> On Dec 21, 2005, at 08:21, Trond Myklebust wrote:
> > ...and if you stick in a faster server?...
> >
> > There is _NO_ fundamental difference between NFS and a local  
> > filesystem that warrants marking one as "interactive" and the other  
> > as "noninteractive". What you are basically saying is that all I/O  
> > should be marked as TASK_NONINTERACTIVE.
> 
> Uhh, what part of disk/NFS/filesystem access is "interactive"?  Which  
> of those sleeps directly involve responding to user-interface  
> events?  _That_ is the whole point of the interactivity bonus, and  
> precisely why Ingo introduced TASK_NONINTERACTIVE sleeps; so that  
> processes that are not being useful for interactivity could be moved  
> away from TASK_NONINTERRUPTABLE, with the end result that the X- 
> server could be run at priority 0 without harming interactivity, even  
> during heavy *disk*, *NFS*, and *network* activity.  Admittedly, that  
> may not be what some people want, but they're welcome to turn off the  
> interactivity bonuses via some file in /proc (sorry, don't remember  
> which at the moment).

Then have io_schedule() automatically set that flag, and convert NFS to
use io_schedule(), or something along those lines. I don't want a bunch
of RT-specific flags littering the NFS/RPC code.

Cheers,
 Trond

