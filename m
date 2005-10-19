Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVJSIPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVJSIPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 04:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVJSIPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 04:15:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:735 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932410AbVJSIPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 04:15:03 -0400
Date: Wed, 19 Oct 2005 01:14:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: Re: [PATCH] .text page fault SMP scalability optimization
Message-Id: <20051019011420.032ccd6d.akpm@osdl.org>
In-Reply-To: <20051019075255.GB30541@x30.random>
References: <20051019075255.GB30541@x30.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> We had a problem on ppc64 where with more than 4 threads a large system
> wouldn't scale well while faulting in the .text (most of the time was
> spent in the kernel despite it was an userland compute intensive app).
> The reason is the useless overwrite of the same pte from all cpu.
> 
> I fixed it this way (verified on an older kernel but the forward port is
> almost identical). This will benefit all archs not just ppc64.

How strange.  Do you mena that all CPUs were entering the pagefault handler
on behalf of the same pte all the time?  That they're staying in lockstep?

If so, there must be a bunch of page_table_lock contention too?
