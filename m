Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWFUFl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWFUFl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 01:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWFUFl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 01:41:58 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:35809 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751159AbWFUFl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 01:41:57 -0400
Message-ID: <4498DC23.2010400@bigpond.net.au>
Date: Wed, 21 Jun 2006 15:41:55 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
References: <1150242721.21787.138.camel@stark>
In-Reply-To: <1150242721.21787.138.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Jun 2006 05:41:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> Task watchers is a notifier chain that sends notifications to registered
> callers whenever a task forks, execs, changes its [re][ug]id, or exits.
> The goal is to keep the these paths comparatively simple while
> enabling the addition of per-task intialization, monitoring, and tear-down
> functions by existing and proposed kernel features.
> 
> The first patch adds a global atomic notifier chain, registration
> functions, and a function to invoke the callers on the chain.
> 
> Later patches:
> 
> Register a task watcher for process events, shuffle bits of process events
> functions around to reduce the code, and turn it into a module. 
> 
> Switch task watchers from an atomic to a blocking notifier chain
> 
> Register task watchers for:
> 	Audit
> 	Per Task Delay Accounting (note: not the taskstats calls)
> 	Profile
> 
> Add a per-task raw notifier chain

This feature is less useful than it could be in that it only allows a 
per-task raw notifier to be added to the current task.  For the per 
process CPU capping client that I'm writing, I'd like to be able to 
attach one of these to a task that's being forked (from the forking 
task).  Not being able to do this will force me to go to the expense of 
maintaining my own hash tables for locating my per task data.

On a related note, I can't see where the new task's notify field gets 
initialized during fork.

> 
> Add a task watcher for semundo
> 
> Switch the semundo task watcher to a per-task watcher
> 
> I've broken up the patches this way for clarity, to allow cherry-picking, and
> to help focus the discussion of any potentially controversial details.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
