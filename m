Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWFFN0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWFFN0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWFFN0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:26:10 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4508 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751306AbWFFN0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:26:08 -0400
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060605084938.GA31915@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net>
	 <1149497459.23209.39.camel@localhost.localdomain>
	 <20060605084938.GA31915@elte.hu>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 09:25:55 -0400
Message-Id: <1149600355.16247.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 10:49 +0200, Ingo Molnar wrote:

> +	/*
> +	 * HACK:
> +	 *
> +	 * In the first pass we dont touch handlers that are behind
> +	 * a disabled IRQ line. In the second pass (having no other
> +	 * choice) we ignore the disabled state of IRQ lines. We've
> +	 * got a screaming interrupt, so we have the choice between
> +	 * a real lockup happening due to that screaming interrupt,
> +	 * against a theoretical locking that becomes possible if we
> +	 * ignore a disabled IRQ line.

FYI,  with irqpoll on in my i386 SMP machine, I hit this theoretical
locking every time in the vortex driver.

-- Steve

> +	 *
> +	 * FIXME: proper disable_irq_handler() API would remove the
> +	 * need for this hack.
> +	 */
> +	if (!ok && first_pass) {
> +		first_pass = 0;
> +		goto repeat;
> +	}
> +
>  	/* So the caller can adjust the irq error counts */
>  	return ok;
>  }


