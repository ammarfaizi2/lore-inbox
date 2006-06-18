Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWFRJvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWFRJvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 05:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFRJvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 05:51:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750778AbWFRJvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 05:51:15 -0400
Date: Sun, 18 Jun 2006 02:50:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: kernel@kolivas.org, sam@vilain.net, bsingharora@gmail.com,
       vatsa@in.ibm.com, pwil3058@bigpond.net.au, dev@openvz.org,
       linux-kernel@vger.kernel.org, efault@gmx.de, kingsley@aurema.com,
       ckrm-tech@lists.sourceforge.net, mingo@elte.hu,
       rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
Message-Id: <20060618025046.77b0cecf.akpm@osdl.org>
In-Reply-To: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 18:26:38 +1000
Peter Williams <pwil3058@bigpond.net.au> wrote:

> These patches implement CPU usage rate limits for tasks.

Via /proc/pid/cpu_rate_cap.  Important detail, that.

People are going to want to extend this to capping a *group* of tasks, with
some yet-to-be-determined means of tying those tasks together.  How well
suited is this code to that extension?

If the task can exceed its cap without impacting any other tasks (ie: there
is spare idle capacity), what happens?  I trust that spare capacity gets
used?  (Is this termed "work conserving"?)

> 5. Code size measurements:
> 
> Vanilla kernel:
> 
>    text    data     bss     dec     hex filename
>   33800    4689     296   38785    9781 sched.o
>    2554      79       0    2633     a49 mutex.o
>   12076    2632       0   14708    3974 base.o
> 
> Patches applied:
> 
>    text    data     bss     dec     hex filename
>   36870    4721     296   41887    a39f sched.o
>    2630      79       0    2709     a95 mutex.o
>   13011    2920       0   15931    3e3b base.o
> 
> Indicating that the size cost of the patch proper is about
> 3 kilobytes and the procfs costs about another 1.2 kilobytes.
> 

hm.  That seems rather a lot.  I guess it's not a simple thing to do.
