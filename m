Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbUK0ESl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUK0ESl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUK0D7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:30 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262440AbUKZTah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:37 -0500
Date: Thu, 25 Nov 2004 19:19:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 17/51: Disable MCE checking during suspend.
Message-ID: <20041125181954.GG1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101295216.5805.256.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101295216.5805.256.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Avoid a potential SMP deadlock here.

..and loose MCE report.
				Pavel

> @@ -57,7 +58,8 @@
>  
>  static void mce_work_fn(void *data)
>  { 
> -	on_each_cpu(mce_checkregs, NULL, 1, 1);
> +	if (!test_suspend_state(SUSPEND_RUNNING))
> +		on_each_cpu(mce_checkregs, NULL, 1, 1);
>  	schedule_delayed_work(&mce_work, MCE_RATE);
>  } 
>  
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

