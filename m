Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWDZEqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWDZEqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWDZEqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:51121 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932357AbWDZEqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:46:47 -0400
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
References: <200604251701.31899.dsp@llnl.gov>
From: Andi Kleen <ak@suse.de>
Date: 26 Apr 2006 06:46:43 +0200
In-Reply-To: <200604251701.31899.dsp@llnl.gov>
Message-ID: <p73k69d7xl8.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> writes:
> 
> Index: git7-oom/include/linux/sched.h
> ===================================================================
> --- git7-oom.orig/include/linux/sched.h	2006-04-25 16:19:40.000000000 -0700
> +++ git7-oom/include/linux/sched.h	2006-04-25 16:21:48.000000000 -0700
> @@ -350,6 +350,8 @@ struct mm_struct {
>  	/* aio bits */
>  	rwlock_t		ioctx_list_lock;
>  	struct kioctx		*ioctx_list;
> +
> +	int oom_notify;

That wastes 4 bytes for a single bit. Please put a flag into some of the existing 
flag bitmaps instead.

-Andi
