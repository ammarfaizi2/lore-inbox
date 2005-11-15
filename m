Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVKOBvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKOBvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKOBvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:51:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62860 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932250AbVKOBvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:51:46 -0500
Date: Mon, 14 Nov 2005 17:51:40 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051114175140.06c5493a.pj@sgi.com>
In-Reply-To: <20051115010155.GA3792@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge wrote:
> But when one of the
> processes looks for process 10, task_vpid_to_pid(current, 10) will return
> the real pid for the vpid 10 in current's pidspace.

So a "kill -1 10" will mean different things, depending on the pidspace
that the kill is running in.  And pid's passed about between user
tasks as if they were usable system-wide are now aliased by their
invisible pidspace.

Yuck.  Such virtualizations usually have a much harder time addressing
the last 10% of situations than they did the easy 90%.

How about instead having a way to put the pid's of checkpointed tasks
in deep freeze, saving them for reuse when the task restarts?

System calls that operate on pid values could error out with some
new errno, -EFROZEN or some such.

This would seem far less invasive.  Not just less invasive of the code,
but more importantly, not introducing some never entirely realizable
semantic change to the scope of pids.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
