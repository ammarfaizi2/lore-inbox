Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVKOL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVKOL7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVKOL7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:59:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24991 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932382AbVKOL7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:59:51 -0500
Date: Tue, 15 Nov 2005 05:59:43 -0600
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115115943.GB9976@lnx-holt.americas.sgi.com>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1> <20051114223513.3145db39.pj@sgi.com> <20051115081100.GA2488@IBM-BWN8ZTBWAO1> <20051115010624.2ca9237d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115010624.2ca9237d.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 01:06:24AM -0800, Paul Jackson wrote:
> No - tasks get the pid the kernel gives them at fork, as always.
> The task keeps that exact same pid, across all checkpoints, restarts
> and migrations.  Nothing that the application process has to worry
> about, either inside the kernel code or in userspace, beyond the fork
> code honoring the assigned pid range when allocating a new pid.

Paul, this approach seems very risky at best.  How do you checkpoint,
stop, reboot the system, and restart?  Does the system recall that a
checkpoint occured and then reserve those from early in boot?  What about
a checkpointed task which is completed on a different system?  How is
that handled?  What if the checkpointed and terminated task is deemed
not worth restarting, how do you inform the system to reuse the pids.
Just seems like a hornets nest.

I would think _for_pids_and_not_everything, the checkpoint could write
out the core file and a restart file.  The restart file would contain the
pid related information.  Then the restart tool could use a preloader to
intercept system calls that specify pids and translate pids from old to
new.  It might not be as easy as using the kernel, but it makes some sense
to from my limited point of view and makes the kernel code less polluted.

Robin
