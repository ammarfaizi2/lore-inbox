Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWHCN4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWHCN4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHCN4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:56:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:4243 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932426AbWHCN4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:56:20 -0400
Message-ID: <44D20079.2000601@watson.ibm.com>
Date: Thu, 03 Aug 2006 09:56:09 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
       balbir@in.ibm.com, jes@sgi.com, csturtiv@sgi.com, tee@sgi.com,
       guillaume.thouvenin@bull.net
Subject: Re: [patch 1/3] basic accounting over taskstats
References: <44D179A5.4000606@engr.sgi.com> <20060802235219.25a072e7.akpm@osdl.org>
In-Reply-To: <20060802235219.25a072e7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> Or we remove this field altogether, perhaps.  The same info is available
> from /proc/pid/stat anyway.  Is it really needed?
> 

Gathering this data in userspace from /proc might be
difficult esp. for short-lived tasks.

Also, /proc may not be mounted ? I'd heard somewhere that
some sysadmins don't install /proc for security reasons.
Don't know how far thats true.

Several other fields, totalling 58 bytes, added by the CSA
patches are also duplicated in /proc/pid/stat. But all of them
could change in value during the lifetime of a task so I'm
guessing its not useful to get them from /proc
even if some kind of userspace polling of the value was
possible.

But if there is a way, it would sure save a lot of payload
sent over taskstats !

"duplicate" fields from CSA:
+	__u8	ac_nice;		/* task_nice */
+	char	ac_comm[TS_COMM_LEN];	/* Command name */
+	__u8	ac_sched;		/* Scheduling discipline */
+	__u32	ac_pid;			/* Process ID */
+	__u32	ac_ppid;		/* Parent process ID */
+	__u64	ac_utime;		/* User CPU time [usec] */
+	__u64	ac_stime;		/* SYstem CPU time [usec] */
+	__u64	ac_minflt;		/* Minor Page Fault */
+	__u64	ac_majflt;		/* Major Page Fault */
