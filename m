Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbTJEQMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTJEQMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:12:08 -0400
Received: from gprs145-86.eurotel.cz ([160.218.145.86]:42369 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263145AbTJEQMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:12:05 -0400
Date: Sun, 5 Oct 2003 18:11:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: JFFS2 swsusp / signal cleanup.
Message-ID: <20031005161155.GA753@elf.ucw.cz>
References: <1065266733.16088.91.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065266733.16088.91.camel@imladris.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> How's this look?

Is flush_signals() really so stupid to do? Goal was to make
modifications to code as simple as possible, and as most pieces do not
expect to be interrupted, pretending signal never happened seems like
good idea...
								Pavel

> @@ -104,6 +105,13 @@
>  			schedule();
>  		}
>  
> +		if (current->flags & PF_FREEZE) {
> +			refrigerator(0);	/* When this loses its stupid flush_signals() 
> +						   and starts just calling recalc_sigpending(),
> +						   you can remove the following: */
> +			recalc_sigpending();
> +		}
> +
>  		cond_resched();
>  
>  		/* Put_super will send a SIGKILL and then wait on the sem. 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
