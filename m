Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVLUNhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVLUNhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVLUNhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:37:05 -0500
Received: from smtpout.mac.com ([17.250.248.89]:55279 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932411AbVLUNhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:37:04 -0500
In-Reply-To: <1135171280.7958.16.camel@lade.trondhjem.org>
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <1135171280.7958.16.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client	on	interactive response
Date: Wed, 21 Dec 2005 08:36:45 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 21, 2005, at 08:21, Trond Myklebust wrote:
> ...and if you stick in a faster server?...
>
> There is _NO_ fundamental difference between NFS and a local  
> filesystem that warrants marking one as "interactive" and the other  
> as "noninteractive". What you are basically saying is that all I/O  
> should be marked as TASK_NONINTERACTIVE.

Uhh, what part of disk/NFS/filesystem access is "interactive"?  Which  
of those sleeps directly involve responding to user-interface  
events?  _That_ is the whole point of the interactivity bonus, and  
precisely why Ingo introduced TASK_NONINTERACTIVE sleeps; so that  
processes that are not being useful for interactivity could be moved  
away from TASK_NONINTERRUPTABLE, with the end result that the X- 
server could be run at priority 0 without harming interactivity, even  
during heavy *disk*, *NFS*, and *network* activity.  Admittedly, that  
may not be what some people want, but they're welcome to turn off the  
interactivity bonuses via some file in /proc (sorry, don't remember  
which at the moment).

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



