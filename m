Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVAYCim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVAYCim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYCil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:38:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:14269 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261771AbVAYCcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:32:07 -0500
Subject: Re: [PATCH] ppc32: fix powersave with interrupts disabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, waite@skycomputers.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <Pine.LNX.4.61.0501241548380.23263@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0501241548380.23263@blarg.somerset.sps.mot.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 13:31:32 +1100
Message-Id: <1106620292.15850.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 15:51 -0600, Kumar Gala wrote:
> It looks like the problem has to do with entering the powersave routine 
> with irqs disabled. Here is a patch that will only enter powersave if irqs 
> are enabled.
> 
> Entering powersave on PPC while irqs are disabled causes a hang. Only 
> enter powersave if irqs are disabled.

I have a different fix which is to re-enable them (basically to move the
local_irq_disable we do in #ifdef CONFIG_SMP above the whole block,
removing the #else case).

I'm waiting for Ingo's ack about what exact race he's trying to fix
though...

Ben.


