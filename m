Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVCWUTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVCWUTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVCWUTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:19:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:20385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262896AbVCWUTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:19:04 -0500
Date: Wed, 23 Mar 2005 12:18:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to handle paging request in worker_thread on apm resume
Message-Id: <20050323121839.18fd0eb1.akpm@osdl.org>
In-Reply-To: <20050323160652.GB19669@fieldses.org>
References: <20050322040657.GA28404@fieldses.org>
	<20050323023344.62ba883b.akpm@osdl.org>
	<20050323160652.GB19669@fieldses.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> wrote:
>
> > Have you added any code which does schedule_work()?
> 
>  Hm, I don't think so.  But of course I have some nfsv4 patches, and the
>  nfsv4 nfsd code does use schedule_delayed_work().  It's possible the
>  cleanup is wrong, and that bringing nfsd up and down could get nfsv4
>  into some bad state.  I'll take a look.  Would that explain this?

I guess so.  Anything which frees the memory which contains a work_struct
without having correctly descheduled that work_struct would cause this
crash.

