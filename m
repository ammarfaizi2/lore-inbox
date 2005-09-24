Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVIXALk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVIXALk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVIXALk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 20:11:40 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:59436 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S932139AbVIXALj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 20:11:39 -0400
Date: Fri, 23 Sep 2005 17:11:14 -0700
From: Arun Sharma <arun.sharma@google.com>
To: linux-kernel@vger.kernel.org, roland@redhat.com, akpm@osdl.org
Subject: Re: [PATCH] POSIX timers SMP race condition
Message-ID: <20050924001114.GA16682@sharma-home.net>
References: <20050923225444.GB13502@sharma-home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923225444.GB13502@sharma-home.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 03:54:44PM -0700, Arun Sharma wrote:
> -			if (!unlikely(t->exit_state)) {
> +			if (!unlikely(t->flags & PF_EXITING)) {

I just had this problem happen again, after the patch. It looks like we
need to cover other unguarded assignments to tsk->it_prof_expires,
which could possibly race with do_exit().

Or just check for PF_EXITING in run_posix_cpu_timers() and return.

	-Arun
