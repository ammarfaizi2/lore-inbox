Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTDCQZi>; Thu, 3 Apr 2003 11:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTDCQZi>; Thu, 3 Apr 2003 11:25:38 -0500
Received: from havoc.daloft.com ([64.213.145.173]:55758 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261353AbTDCQZh>;
	Thu, 3 Apr 2003 11:25:37 -0500
Date: Thu, 3 Apr 2003 11:37:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@redhat.com>
Subject: Re: IPMI driver version 19 release
Message-ID: <20030403163700.GA13769@gtf.org>
References: <3E8C6022.6060304@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8C6022.6060304@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 10:24:02AM -0600, Corey Minyard wrote:
> @@ -563,8 +576,9 @@
>  		spin_lock_irqsave(&(kcs_info->kcs_lock), flags);
>  		result = kcs_event_handler(kcs_info, 0);
>  		while (result != KCS_SM_IDLE) {
> -			udelay(500);
> -			result = kcs_event_handler(kcs_info, 500);
> +			udelay(KCS_SHORT_TIMEOUT_USEC);
> +			result = kcs_event_handler(kcs_info,
> +						   KCS_SHORT_TIMEOUT_USEC);
>  		}
>  		spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
>  		return;


Do you really want to udelay this long with interrupts disabled?
Certainly comments in kcs_event[_handler] indicate you're aware of the
issue, but the code does not belie this fact :)

Not only is the udelay itself "long" relatively speaking, but it's in a
loop.  Which also calls a function that contains a loop that is
potentially infinite is hardware is being wonky.

	Jeff



