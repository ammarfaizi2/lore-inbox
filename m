Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWBPAaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWBPAaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 19:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWBPAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 19:30:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751010AbWBPA37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 19:29:59 -0500
Date: Wed, 15 Feb 2006 16:28:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: SMP BUG
Message-Id: <20060215162836.278cfafb.akpm@osdl.org>
In-Reply-To: <20060216001409.GG1508@flint.arm.linux.org.uk>
References: <43F12207.9010507@watson.ibm.com>
	<20060215230701.GD1508@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0602151521320.22082@g5.osdl.org>
	<20060215153013.474ff5e0.akpm@osdl.org>
	<20060215233700.GF1508@flint.arm.linux.org.uk>
	<20060215154634.7677edda.akpm@osdl.org>
	<20060216001409.GG1508@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > So I think it's sanest to say that the arch shalt initialise cpu_possible_map
> > in setup_arch().
> 
> Is that the only thing which needs to be initialised early for SMP, or
> are there other changes with early SMP init looming?

Well, I'm not aware of anything - just the patch "percpu data changes" I
sent to linux-arch the other day, which is related to this issue.

The whole early bootup what-the-arch-should-do-when protocol is rather a
mess, so I'm sure other things will need changing.

> The reason I ask is that the cleanest solution for ARM would be to
> introduce yet another initialisation function for MP platforms to
> implement, which setup_arch() will call after the initial page tables
> have been setup.  Hence, I'm wondering if the platform specific parts
> could be simplified by moving more stuff earlier.

That sounds sane.  Perhaps make it a generic setup_arch_platform() whose
mandate is "do whatever needs to be done for setup_arch()".
