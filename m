Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTJIJ2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 05:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTJIJ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 05:28:38 -0400
Received: from gprs149-234.eurotel.cz ([160.218.149.234]:33152 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261956AbTJIJ2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 05:28:37 -0400
Date: Thu, 9 Oct 2003 11:24:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pm] Re: JFFS2 swsusp / signal cleanup.
Message-ID: <20031009092441.GA304@elf.ucw.cz>
References: <1065266733.16088.91.camel@imladris.demon.co.uk> <20031005161155.GA753@elf.ucw.cz> <20031005171916.B21478@flint.arm.linux.org.uk> <20031005191344.GA963@elf.ucw.cz> <1065384453.3157.149.camel@imladris.demon.co.uk> <20031009002318.GB219@elf.ucw.cz> <1065659366.30987.178.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065659366.30987.178.camel@imladris.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Do you need locking for recalc_sigpending()?

Hmm, seems so; btw your patch seems to miss it too:

> @@ -104,6 +105,13 @@
>                       schedule();
>               }
>
> +             if (current->flags & PF_FREEZE) {
> +                     refrigerator(0);        /* When this loses its
> stupid flush_signals()
> +                                                and starts just
> calling recalc_sigpending(),
> +                                                you can remove the
> following: */
> +                     recalc_sigpending();
> +             }
> +
>               cond_resched();
>
>               /* Put_super will send a SIGKILL and then wait on the
> sem.

I'll test it and send updated patch.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
