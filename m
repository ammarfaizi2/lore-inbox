Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVLVC0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVLVC0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 21:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVLVC0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 21:26:52 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:17119 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965035AbVLVC0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 21:26:52 -0500
Message-ID: <43AA0EEA.8070205@bigpond.net.au>
Date: Thu, 22 Dec 2005 13:26:50 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS	client	on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au>	 <1135145341.7910.17.camel@lade.trondhjem.org>	 <43A8F714.4020406@bigpond.net.au>	 <1135171280.7958.16.camel@lade.trondhjem.org>	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com> <1135172453.7958.26.camel@lade.trondhjem.org>
In-Reply-To: <1135172453.7958.26.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 22 Dec 2005 02:26:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2005-12-21 at 08:36 -0500, Kyle Moffett wrote:
> 
>>On Dec 21, 2005, at 08:21, Trond Myklebust wrote:
>>
>>>...and if you stick in a faster server?...
>>>
>>>There is _NO_ fundamental difference between NFS and a local  
>>>filesystem that warrants marking one as "interactive" and the other  
>>>as "noninteractive". What you are basically saying is that all I/O  
>>>should be marked as TASK_NONINTERACTIVE.
>>
>>Uhh, what part of disk/NFS/filesystem access is "interactive"?  Which  
>>of those sleeps directly involve responding to user-interface  
>>events?  _That_ is the whole point of the interactivity bonus, and  
>>precisely why Ingo introduced TASK_NONINTERACTIVE sleeps; so that  
>>processes that are not being useful for interactivity could be moved  
>>away from TASK_NONINTERRUPTABLE, with the end result that the X- 
>>server could be run at priority 0 without harming interactivity, even  
>>during heavy *disk*, *NFS*, and *network* activity.  Admittedly, that  
>>may not be what some people want, but they're welcome to turn off the  
>>interactivity bonuses via some file in /proc (sorry, don't remember  
>>which at the moment).
> 
> 
> Then have io_schedule() automatically set that flag, and convert NFS to
> use io_schedule(), or something along those lines. I don't want a bunch
> of RT-specific flags littering the NFS/RPC code.

This flag isn't RT-specific.  It's used in the scheduling SCHED_NORMAL 
tasks and has no other semantic effects.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
