Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWFVTF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWFVTF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWFVTF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:05:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63123 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161206AbWFVTF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:05:27 -0400
Date: Thu, 22 Jun 2006 17:08:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 6/6] cpu_relax(): ptrace.c coding style fix
Message-ID: <20060622150817.GB2959@openzaurus.ucw.cz>
References: <20060621210046.GF22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621210046.GF22516@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix existing cpu_relax() loop to have proper kernel style.

..but you change the code, not its style.

> @@ -182,9 +182,8 @@
>  	if (!write_trylock(&tasklist_lock)) {
>  		local_irq_enable();
>  		task_unlock(task);
> -		do {
> +		while (!write_can_lock(&tasklist_lock))
>  			cpu_relax();
> -		} while (!write_can_lock(&tasklist_lock));
>  		goto repeat;
>  	}

I guess that barrier was needed before write_can_lock can succeed.
=> your version does one unneccessary test.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

