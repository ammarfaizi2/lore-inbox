Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbTGEBA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 21:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbTGEBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 21:00:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266258AbTGEBA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 21:00:27 -0400
Date: Fri, 4 Jul 2003 18:15:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030704181539.2be0762a.akpm@osdl.org>
In-Reply-To: <20030704210737.GI955@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org>
	<20030704210737.GI955@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Jul 03, 2003 at 02:37:14AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm1/
> 
> anton saw the OOM killer try to kill pdflush, causing tons of spurious
> wakeups. This should avoid picking kernel threads in select_bad_process().
> 
> 
> -- wli
> 
> 
> ===== mm/oom_kill.c 1.23 vs edited =====
> --- 1.23/mm/oom_kill.c	Wed Apr 23 03:15:53 2003
> +++ edited/mm/oom_kill.c	Fri Jul  4 14:03:32 2003
> @@ -123,7 +123,7 @@
>  	struct task_struct *chosen = NULL;
>  
>  	do_each_thread(g, p)
> -		if (p->pid) {
> +		if (p->pid && p->mm) {
>  			int points = badness(p);
>  			if (points > maxpoints) {
>  				chosen = p;

Look at select_bad_process(), and the ->mm test in badness().  pdflush
can never be chosen.

Nevertheless, there have been several report where kernel threads _are_ 
being hit my the oom killer.  Any idea why that is?

