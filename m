Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVCOTRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVCOTRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVCOTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:14:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:5831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261796AbVCOTNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:13:24 -0500
Date: Tue, 15 Mar 2005 11:12:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: rostedt@goodmis.org
Cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-Id: <20050315111255.5ac36d8a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503150843410.6456@localhost.localdomain>
References: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
	<1110574019.19093.23.camel@mindpipe>
	<1110578809.19661.2.camel@mindpipe>
	<Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
	<Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
	<Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
	<Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503150843410.6456@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The problem here is that it's not ext3 bh's only. They're still the normal
>  buffer head.  The problem arrises because the ext3 "journal head" is
>  allocated within these bit spin locks.

Yes, the locks do want to live inside the buffer_head.

Stephen has pointed out that we might want to remove
jbd_lock_bh_journal_head() altogether some time, just use
jbd_lock_bh_state() for that.

In 2.4 these locks are global (or per-superblock).  Making them a global
spinlock would be acceptable for 2-ways and probably larger.

