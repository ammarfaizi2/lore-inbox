Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755492AbWKZT2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbWKZT2p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbWKZT2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:28:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:49333 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755492AbWKZT2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:28:44 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: touch softlockup during
Date: Sun, 26 Nov 2006 20:26:57 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061126064704.GA5126@redhat.com>
In-Reply-To: <20061126064704.GA5126@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611262026.57604.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 07:47, Dave Jones wrote:
> Sometimes the soft watchdog fires after we're done oopsing.
> See http://projects.info-pull.com/mokb/MOKB-25-11-2006.html for an example.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.18.noarch/arch/i386/kernel/traps.c~	2006-11-26 01:40:58.000000000 -0500
> +++ linux-2.6.18.noarch/arch/i386/kernel/traps.c	2006-11-26 01:41:28.000000000 -0500
> @@ -243,6 +243,7 @@ void dump_trace(struct task_struct *task
>  		stack = (unsigned long*)context->previous_esp;
>  		if (!stack)
>  			break;
> +		touch_softlockup_watchdog();

These should be all touch_nmi_watchdog() (which does touch the soft watchdog
too) 

-Andi
