Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTFPIFB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTFPIFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:05:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19281 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263542AbTFPIE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:04:59 -0400
Date: Mon, 16 Jun 2003 01:19:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: rusty@rustcorp.com.au, neilb@cse.unsw.edu.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in
 modules.
Message-Id: <20030616011919.009b1c93.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0306160907470.2079-100000@notebook.home.mdiehl.de>
References: <20030616065058.D1C9E2C08A@lists.samba.org>
	<Pine.LNX.4.44.0306160907470.2079-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2003 08:18:52.0073 (UTC) FILETIME=[EBA5A190:01C333DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Diehl <lists@mdiehl.de> wrote:
>
>  > create_thread would use keventd to start the thread, and stop_thread
>  > would tell keventd to set should_die, wmb(), wake it up, and
>  > sys_wait() for it.
>  > 
>  > Thoughts?
>  > Rusty.
> 
>  Why using keventd?

keventd knows how to clean up children, handle SIGCHLD, etc.  That code was
hard-won.

And kernel threads which are parented by userspace processes tend to
accidentally inherit things we'd rather they didn't.  daemonize() and
reparent_to_init() try to fix things up, but I'm still not sure we got it
all.

Using keventd will tend to prevent mistakes.

