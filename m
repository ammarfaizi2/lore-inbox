Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbSLSADc>; Wed, 18 Dec 2002 19:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbSLSADc>; Wed, 18 Dec 2002 19:03:32 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:27155
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267390AbSLSADb>; Wed, 18 Dec 2002 19:03:31 -0500
Subject: Re: [PATCH 2.5.52] Use __set_current_state() instead of
	current->state = (take 1)
From: Robert Love <rml@tech9.net>
To: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc: torvalds@transmeta.org, linux-kernel@vger.kernel.org
In-Reply-To: <E18Oo3e-0007gl-00@milikk>
References: <E18Oo3e-0007gl-00@milikk>
Content-Type: text/plain
Organization: 
Message-Id: <1040256697.848.79.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 19:11:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 18:56, Inaky Perez-Gonzalez wrote:

> In fs/*.c, many functions manually set the task state directly
> accessing current->state, or with a macro, kind of
> inconsistently. This patch changes all of them to use
> [__]set_current_state().

Some of these should probably be set_current_state().  I realize the
current code is equivalent to __set_current_state() but it might as well
be done right.

> diff -u fs/locks.c:1.1.1.6 fs/locks.c:1.1.1.1.6.2
> --- fs/locks.c:1.1.1.6	Wed Dec 11 11:13:35 2002
> +++ fs/locks.c	Wed Dec 18 13:20:24 2002
> @@ -571,7 +571,7 @@
>  	int result = 0;
>  	DECLARE_WAITQUEUE(wait, current);
>  
> -	current->state = TASK_INTERRUPTIBLE;
> +	__set_current_state (TASK_INTERRUPTIBLE);
>  	add_wait_queue(fl_wait, &wait);
>  	if (timeout == 0)

At least this guy should be set_current_state(), on quick glance.

When in doubt just use set_current_state()..

	Robert Love

