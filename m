Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWCaJe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWCaJe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCaJe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:34:28 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:50364 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751292AbWCaJe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:34:28 -0500
Date: Fri, 31 Mar 2006 11:31:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.16-mm2 patch] don't awaken RT tasks on expired array
Message-ID: <20060331093159.GA16944@elte.hu>
References: <1143796729.7524.14.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143796729.7524.14.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> RT tasks are being awakened on the expired array when 
> expired_starving() is true, whereas they really should be excluded.  
> Fix below.
> 	
> Signed-off-by: Mike Galbraith <efault@gmx.de>

indeed, good catch.

Acked-by: Ingo Molnar <mingo@elte.hu>

> --- linux-2.6.16-mm2/kernel/sched.c.org	2006-03-31 09:56:37.000000000 +0200
> +++ linux-2.6.16-mm2/kernel/sched.c	2006-03-31 10:01:54.000000000 +0200
> @@ -820,7 +820,7 @@
>  {
>  	prio_array_t *target = rq->active;

[nit: please use -p when generating patches. If you are using quilt you 
can use QUILT_DIFF_OPTS="-p" in your .bashrc, and do 'quilt diff 
--no-timestamps --sort' to get pretty patch output.]

	Ingo
