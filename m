Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVI1VgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVI1VgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVI1VgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:36:17 -0400
Received: from 216-239-33-25.google.com ([216.239.33.25]:2784 "EHLO
	216-239-33-25.google.com") by vger.kernel.org with ESMTP
	id S1750953AbVI1VgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:36:16 -0400
Date: Wed, 28 Sep 2005 14:35:36 -0700
From: Arun Sharma <arun.sharma@google.com>
To: linux-kernel@vger.kernel.org, roland@redhat.com, akpm@osdl.org
Subject: Re: [PATCH] POSIX timers SMP race condition
Message-ID: <20050928213536.GA3048@sharma-home.net>
References: <20050923225444.GB13502@sharma-home.net> <20050924001114.GA16682@sharma-home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924001114.GA16682@sharma-home.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 05:11:14PM -0700, Arun Sharma wrote:
> On Fri, Sep 23, 2005 at 03:54:44PM -0700, Arun Sharma wrote:
> > -			if (!unlikely(t->exit_state)) {
> > +			if (!unlikely(t->flags & PF_EXITING)) {
> 
> I just had this problem happen again, after the patch. It looks like we
> need to cover other unguarded assignments to tsk->it_prof_expires,
> which could possibly race with do_exit().

False alarm, sorry. The kernel turned out be unpatched. I haven't seen 
the BUG() since then.

	-Arun
