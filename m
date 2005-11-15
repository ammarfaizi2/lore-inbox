Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVKOKHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVKOKHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVKOKHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:07:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59107 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932336AbVKOKHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:07:19 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
In-Reply-To: <20051115010624.2ca9237d.pj@sgi.com>
References: <20051114212341.724084000@sergelap>
	 <20051114153649.75e265e7.pj@sgi.com>
	 <20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	 <20051114175140.06c5493a.pj@sgi.com>
	 <20051115022931.GB6343@sergelap.austin.ibm.com>
	 <20051114193715.1dd80786.pj@sgi.com>
	 <20051115051501.GA3252@IBM-BWN8ZTBWAO1>
	 <20051114223513.3145db39.pj@sgi.com>
	 <20051115081100.GA2488@IBM-BWN8ZTBWAO1>
	 <20051115010624.2ca9237d.pj@sgi.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 11:07:10 +0100
Message-Id: <1132049230.6108.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 01:06 -0800, Paul Jackson wrote:
> No - tasks get the pid the kernel gives them at fork, as always.
> The task keeps that exact same pid, across all checkpoints, restarts
> and migrations.  Nothing that the application process has to worry
> about, either inside the kernel code or in userspace, beyond the fork
> code honoring the assigned pid range when allocating a new pid.

The main issues I worry about with such a static allocation scheme are
getting the allocation patterns right, without causing new restrictions
on the containers.  This kind of scheme is completely thrown out the
window if someone wanted to start a process on their disconnected laptop
and later migrate it to another machine when they connect back up to the
network.  

> The real complexity comes, I claim, from changing the pid from a
> system-wide name space to a partially per-job namespace.  You can
> never do that conversion entirely and will always have confusions
> around the edges, as pids relative to one virtual server are used,
> incorrectly, in the environment of another virtual server or system
> wide.

You're basically concerned about pids "leaking" across containers, and
confusing applications in the process?  That's a pretty valid concern.
However, the long-term goal here is to virtualize more than pids.  As
you noted, this will include thing like shm ids.  Yes, I worry that
we'll end up modifying a _ton_ of stuff in the process of doing this.

As for passing confusing pids from different namespaces in the
filesystem, like in /var/run, there are solutions in the pipeline.
Private namespaces and versioned filesystems should be able to cope with
this kind of isolation very nicely.

-- Dave

