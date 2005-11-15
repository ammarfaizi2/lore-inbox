Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVKOGfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVKOGfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVKOGfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:35:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8094 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932286AbVKOGfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:35:19 -0500
Date: Mon, 14 Nov 2005 22:35:13 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051114223513.3145db39.pj@sgi.com>
In-Reply-To: <20051115051501.GA3252@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
	<20051114193715.1dd80786.pj@sgi.com>
	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge wrote:
> Well a vserver pretends to be a full system of its own

Do you have any references, links?

> In fact this is one way we considered implementing the virtual pids -

No no - not what I meant.  I meant to have the pid be the same in all
views, for all time, kernel and user, inside and outside the virtual
server.  Just like pids are now.  A given virtual server would have
a dedicated range of pids, reserved for it on all hardware systems
in the farm.

You could move the tasks in one such virtual server from one hardware
system to another without having pid collisions because the destination
hardware system would have been reserving those pids all along for
that virtual server.

The additional kernel facilities this would require:
 1) For a given task (inherited) designate which pid range to use for
    newly forked children.
 2) Restart a task into the same pid it had before, which would fail
    if that pid was in use by any other task on the system.

Administratively, create named virtual servers, each one assigned
a permanent pid range.  On each hardware system, each task would
be managed to be using pids for forking from the pid range for the
virtual server it was running in.

Perhaps each hardware system would have one pid range, say pids
0..2000, overlapping with all other such systems, for tasks specific
to that hardware system.  These tasks could not be checkpoint/restarted
on another hardware system.

For example, the virtual server "magnolia" would always have pids
9,000 to 9,999, and all hardware systems in the server farm would
keep this pid range open for running "magnolia", if asked to.  If you
saw a tasks pid was 9.543, then you would immediately know it ran
on virtual server "magnolia."

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
