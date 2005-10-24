Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVJXGlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVJXGlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 02:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVJXGlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 02:41:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751027AbVJXGlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 02:41:51 -0400
Date: Sun, 23 Oct 2005 23:40:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com, torvalds@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH] cpuset confine pdflush to its cpuset
Message-Id: <20051023234032.5e926336.akpm@osdl.org>
In-Reply-To: <20051023233237.0982b54b.pj@sgi.com>
References: <20051024001913.7030.71597.sendpatchset@jackhammer.engr.sgi.com>
	<20051024.145258.98349934.taka@valinux.co.jp>
	<20051023233237.0982b54b.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Takahashi-san wrote:
> > I realized CPUSETS has another problem around pdflush.
> 
> Excellent observation.  I had not realized this.
> 
> Thank-you for pointing it out.
> 
> I don't have plans.  Do you have any suggestions?

Per-zone dirty thresholds (quite messy), per-zone writeback (horrific,
linear searches or data structure proliferation everywhere).

Let's see a (serious) worload/testcase first, hey?  vmscan.c writeback off
the LRU is a bit slow, but we should be able to make it suffice.

>   ( Anyone know what the "pd" stands for in pdflush ?? )

"page dirty"?  It's what bdflush became when writeback went from
being block-based to being page-based.
