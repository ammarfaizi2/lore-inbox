Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUH2VPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUH2VPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUH2VPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:15:07 -0400
Received: from peabody.ximian.com ([130.57.169.10]:60588 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268305AbUH2VPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:15:02 -0400
Subject: Re: interrupt cpu time accounting?
From: Robert Love <rml@ximian.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
In-Reply-To: <41323FA8.80203@pobox.com>
References: <41323FA8.80203@pobox.com>
Content-Type: text/plain
Date: Sun, 29 Aug 2004 17:15:02 -0400
Message-Id: <1093814102.2595.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 16:42 -0400, Jeff Garzik wrote:
> Does the kernel scheduler notice when a CPU spends a lot of time doing 
> interrupt processing?
> 
> For many network configurations you get the best cache affinity, etc. if 
> you lock network interrupts to a single CPU.  However, on a box with 
> high network load, that could mean that that CPU is spending more time 
> processing interrupts than doing Real Work(tm).
> 
> Will the scheduler "notice" this, and increasingly schedule processes 
> away from the interrupt-heavy CPU?

Nope, not explicitly anyhow.

Implicitly, at least, the load balancer will ensure that the runnable
processes on the processor do not get "backed up" due to the delayed
processing but you will still have the balanced minimum number of
processes there.

I don't know whether the answer is to use cpu affinity and not schedule
processes on that processor when you bind interrupts to it, or an
automatic algorithm in the load balance for doing it, but that is a neat
idea.

	Robert Love


