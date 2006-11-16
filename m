Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424728AbWKPV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424728AbWKPV7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424730AbWKPV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:59:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424728AbWKPV7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:59:20 -0500
Date: Thu, 16 Nov 2006 13:59:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hotplug CPU: clean up hotcpu_notifier() use
In-Reply-To: <20061116093228.GA15603@elte.hu>
Message-ID: <Pine.LNX.4.64.0611161357380.3349@woody.osdl.org>
References: <20061116084855.GA8848@elte.hu> <20061116090330.GA11312@elte.hu>
 <20061116093228.GA15603@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2006, Ingo Molnar wrote:
>
> the cpu-hotplug related warning is solved by the cleanup below.

I do not believe this is a cleanup, at least not in this kind of form:

> @@ -1777,8 +1775,8 @@ xfs_icsb_init_counters(
>  #ifdef CONFIG_HOTPLUG_CPU
>  	mp->m_icsb_notifier.notifier_call = xfs_icsb_cpu_notify;
>  	mp->m_icsb_notifier.priority = 0;
> -	register_hotcpu_notifier(&mp->m_icsb_notifier);
>  #endif /* CONFIG_HOTPLUG_CPU */
> +	register_hotcpu_notifier(&mp->m_icsb_notifier);

That's just horrible. Now you "register" that notifier that you've never 
actually even initialized.

The new code is a lot worse than the old code at least in this case.

		Linus
