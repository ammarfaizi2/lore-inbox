Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265116AbSJOXDn>; Tue, 15 Oct 2002 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264971AbSJOXCW>; Tue, 15 Oct 2002 19:02:22 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:15629 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265136AbSJOWzS>; Tue, 15 Oct 2002 18:55:18 -0400
Date: Wed, 16 Oct 2002 00:01:06 +0100
From: John Levon <levon@movementarian.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [4/7] oprofile - NMI hook
Message-ID: <20021015230106.GA43030@compsoc.man.ac.uk>
References: <20021015223319.GD41906@compsoc.man.ac.uk> <m33cr7l3ab.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33cr7l3ab.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181agU-000Di1-00*0pYM0kbfDp2* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 12:56:28AM +0200, Andi Kleen wrote:

> > This patch provides a simple api to let oprofile hook into
> > the NMI interrupt for the perfctr profiler.
> 
> I would suggest using a notifier list instead (include/linux/notifier.h) 
> This would handle multiple users cleanly.

How ? The only safe way I can see would be to spin lock around the NMI
(and try lock when an NMI arrives).  This would either make every NMI
contend on a single spinlock, or require a NR_CPUS-sized array of
spinlocks, which is just ugly. And that wouldn't solve the
power-management problem - any NMI users need to collaborate to disable
NMI generation on a suspend.

regards
john

-- 
"CUT IT OUT FACEHEAD"
	- jeffk
