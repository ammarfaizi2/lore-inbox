Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUGZAiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUGZAiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUGZAiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:38:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:1773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264701AbUGZAiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:38:17 -0400
Date: Sun, 25 Jul 2004 17:36:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] Autotune swappiness01
Message-Id: <20040725173652.274dcac6.akpm@osdl.org>
In-Reply-To: <cone.1090801520.852584.20693.502@pc.kolivas.org>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Attached is a patch designed to improve the behaviour of the swappiness knob 
> in 2.6.8-rc1-mm1. 
> 
> The current mechanism decides to reclaim mapped pages based on the 
> combination of mapped_ratio/2 and the manual setting of swappiness currently 
> tuned to 60. Biasing this mechanism to be proportional to the square root of 
> mapped_ratio gives good overall performance improvement for desktop 
> workloads without any noticable detriment to other loads.

OK...

> It has the effect 
> of being fairly aggressive at avoiding loss of applications to swap under 
> conditions of heavy or sustained file stress while allowing applications to 
> swap out under what would be considered "application" memory stresses on a 
> desktop.

But decreasing /proc/sys/vm/swappiness does that too?

> It has no measurable effect on any known benchmarks.

So how are we to evaluate the desirability of the patch???

> The swappiness knob is kept intact and ironically is set to the same value 
> of 60, and overall behaves the same as previous patches posted for 
> autoregulating swappiness. The idea of this patch is to ultimately deprecate 
> the need for a swappiness knob if this achieves good performance in most 
> workloads.

Don't think so.  If you have a machine with a lot of memory which is doing
mainly pagecache-intensive work and you also want it to aggressively swap
out anonymous pages (ie: your initials are akpm) then you'll be setting
swappiness to 100.


Shouldn't mapped_bias be local to refill_inactive_zone()?

Why is `swappiness' getting squared?  AFAICT this will simply make the
swappiness control behave nonlinearly, which seems undesirable?

