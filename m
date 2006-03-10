Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752110AbWCJUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWCJUYR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWCJUYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:24:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752109AbWCJUYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:24:15 -0500
Date: Fri, 10 Mar 2006 12:21:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: dev@openvz.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations
 inside
Message-Id: <20060310122146.1da0cf1d.akpm@osdl.org>
In-Reply-To: <441178CF.7040705@tls.msk.ru>
References: <44106393.2050207@openvz.org>
	<441178CF.7040705@tls.msk.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Kirill Korotaev wrote:
> > This patch fixes illegal __GFP_FS allocation inside ext3
> > transaction in ext3_symlink().
> > Such allocation may re-enter ext3 code from
> > try_to_free_pages. But JBD/ext3 code keeps a pointer to current
> > journal handle in task_struct and, hence, is not reentrable.
> > 
> > This bug led to "Assertion failure in journal_dirty_metadata()" messages.
> > 
> > http://bugzilla.openvz.org/show_bug.cgi?id=115
> 
> Is it the same bug as http://marc.theaimsgroup.com/?t=113870577100003&r=1&w=2 ?
> 

yes.
