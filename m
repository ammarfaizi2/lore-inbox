Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbUK0ESg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUK0ESg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUK0D6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:58:21 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262459AbUKZTbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:07 -0500
Date: Thu, 25 Nov 2004 19:33:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
Message-ID: <20041125183332.GJ1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296026.5805.275.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101296026.5805.275.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Included in this patch is a new try_to_freeze() macro Andrew M suggested
> a while back. The refrigerator declarations are put in sched.h to save
> extra includes of suspend.h.

try_to_freeze looks nice. Could we get it in after 2.6.10 opens?

> +++ 582-refrigerator-new/drivers/pnp/pnpbios/core.c	2004-11-24 17:58:33.769748640 +1100
> @@ -179,6 +179,10 @@
>  		 * Poll every 2 seconds
>  		 */
>  		msleep_interruptible(2000);
> +
> +		if(current->flags & PF_FREEZE)
> +			refrigerator(PF_FREEZE);
> +
>  		if(signal_pending(current))
>  			break;
>  

Use new interface here?

>   */
>  int fsync_super(struct super_block *sb)
>  {
> +	int ret;
> +
> +	/* A safety net. During suspend, we might overwrite
> +	 * memory containing filesystem info. We don't then
> +	 * want to sync it to disk. */
> +	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
> +		return 0;
> +	

If it is safety net, do BUG_ON().
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

