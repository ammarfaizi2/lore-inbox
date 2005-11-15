Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVKONc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVKONc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVKONc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:32:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:34455 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932484AbVKONcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:32:25 -0500
Date: Tue, 15 Nov 2005 07:32:22 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115133222.GA2232@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1> <20051114223513.3145db39.pj@sgi.com> <20051115081100.GA2488@IBM-BWN8ZTBWAO1> <20051115010624.2ca9237d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115010624.2ca9237d.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> > But in the end isn't that more complicated than our approach?  The
> > kernel still needs to be modified to let processes request their pids,
> 
> No - getpid() works, as always.  Perhaps I don't understand your
> comment.
> 
> 
> > and now processes have to worry *always* about the value or range of
> > their pids, both at startup and restart. 
> 
> No - tasks get the pid the kernel gives them at fork, as always.
> The task keeps that exact same pid, across all checkpoints, restarts
> and migrations.  Nothing that the application process has to worry
> about, either inside the kernel code or in userspace, beyond the fork
> code honoring the assigned pid range when allocating a new pid.

Ok, so we have fork code to dole out pid ranges per vserver, I see where
the app doesn't need to request a pid on startup.  But what about restart?
Surely the app still needs to be restarted with the same pid - just that
now we are more trusting that the pid remains available bc of the pid
ranges?

> No wide spread kernel code change, compared to yours.  As now, tasks

Note that while the patch is large, so far its main purpose is to introduce
a clean concept rather than hack the vpid idea in.  The latter has beem done
before, and only requires intercepting the points where pids go from user
to kernel.  This leaves the question of which pid is which more ambiguous.

-serge

