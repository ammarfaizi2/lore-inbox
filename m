Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272215AbTHRSJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272219AbTHRSJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:09:46 -0400
Received: from [63.247.75.124] ([63.247.75.124]:9621 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272215AbTHRSJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:09:43 -0400
Date: Mon, 18 Aug 2003 14:09:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
Message-ID: <20030818180941.GJ24693@gtf.org>
References: <200308181806.h7II6K6D014918@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308181806.h7II6K6D014918@hera.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 04:59:53PM +0000, Linux Kernel Mailing List wrote:
> @@ -425,7 +414,7 @@
>  	
>  	*tty->flip.char_buf_ptr++ = ch;
>  	tty->flip.count++;
> -	queue_task(&tty->flip.tqueue, &tq_timer);
> +	schedule_delayed_work(&tty->flip.work, 1);
>  }
>  
>  static inline void rc_receive(struct riscom_board const * bp)
> @@ -456,7 +445,7 @@
>  		*tty->flip.flag_buf_ptr++ = 0;
>  		tty->flip.count++;
>  	}
> -	queue_task(&tty->flip.tqueue, &tq_timer);
> +	schedule_delayed_work(&tty->flip.work, 1);
>  }
>  
>  static inline void rc_transmit(struct riscom_board const * bp)

Should we just make schedule_delayed_work(foo, 1) the default for a 
schedule_work() call?

I'm seeing this construct pop up more and more... and would rather have
it fixed at the source, not in every driver.

	Jeff



