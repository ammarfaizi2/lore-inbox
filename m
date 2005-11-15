Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVKOILG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVKOILG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVKOILF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:11:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:31373 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751371AbVKOILE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:11:04 -0500
Date: Tue, 15 Nov 2005 02:11:00 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115081100.GA2488@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1> <20051114223513.3145db39.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114223513.3145db39.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> Serge wrote:
> > Well a vserver pretends to be a full system of its own
> 
> Do you have any references, links?

Oh - linux-vserver.org

> > In fact this is one way we considered implementing the virtual pids -
> 
> No no - not what I meant.  I meant to have the pid be the same in all
> views, for all time, kernel and user, inside and outside the virtual
> server.  Just like pids are now.  A given virtual server would have
> a dedicated range of pids, reserved for it on all hardware systems
> in the farm.

But in the end isn't that more complicated than our approach?  The
kernel still needs to be modified to let processes request their pids,
and now processes have to worry *always* about the value or range of
their pids, both at startup and restart.  In the pidspace approach,
processes simply have a concept of starting a new pidspace, after
which the rest of the system processes are effectively gone as far as
this pidspace is concerned, and, other than that, processes continue
as normal.  Upon restart, they do have to reclaim their vpids, either
from userspace, or through in-kernel restart code.

-serge

