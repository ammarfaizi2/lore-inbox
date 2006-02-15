Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWBOGsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWBOGsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBOGsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:48:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422885AbWBOGsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:48:47 -0500
Date: Tue, 14 Feb 2006 22:47:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, pj@sgi.com, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH] Cpuset: oops in exit on null cpuset fix
Message-Id: <20060214224710.35887069.akpm@osdl.org>
In-Reply-To: <20060215063058.22043.61848.sendpatchset@jackhammer.engr.sgi.com>
References: <20060215063058.22043.61848.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  Fix a latent bug in cpuset_exit() handling.  If a task tried
>  to allocate memory after calling cpuset_exit(), it oops'd in
>  cpuset_update_task_memory_state() on a NULL cpuset pointer.
> 
>  So set the exiting tasks cpuset to the root cpuset instead of
>  to NULL.
> 
>  A distro kernel hit this with an added kernel package that had
>  just such a hook (allocating memory) in the exit code path.

Seems strange to patch the kernel for this.  Can't the add-on patch do it? 
Or can we just move the cpuset_exit()s to later in the exit() paths?
