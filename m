Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVAHNBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVAHNBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVAHNBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:01:25 -0500
Received: from zork.zork.net ([64.81.246.102]:24466 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261153AbVAHNBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:01:23 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP Oops (was Re: 2.6.10-mm2)
References: <20050106002240.00ac4611.akpm@osdl.org>
	<6umzvkhfl5.fsf@zork.zork.net> <20050107173607.1fc69878.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 08 Jan 2005 13:01:22 +0000
In-Reply-To: <20050107173607.1fc69878.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 7 Jan 2005 17:36:07 -0800")
Message-ID: <6u6528gjml.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Sean Neakums <sneakums@zork.net> wrote:
>>
>> Got the following upon starting X (Debian sid's 4.3.0.dfsg.1-10).
>> Was fine with 2.6.10-mm1.  Radeon card, VIA AGP.
>> 
>
> Did you have this?

That fixes it.  Thanks!

> --- 25/drivers/char/agp/generic.c~agpgart-add-bridge-assignment-missed-in-agp_allocate_memory	Thu Jan  6 15:50:18 2005
> +++ 25-akpm/drivers/char/agp/generic.c	Thu Jan  6 15:50:18 2005
> @@ -211,6 +211,7 @@ struct agp_memory *agp_allocate_memory(s
>  		new->memory[i] = virt_to_phys(addr);
>  		new->page_count++;
>  	}
> +       new->bridge = bridge;
>  
>  	flush_agp_mappings();
>  
> _
