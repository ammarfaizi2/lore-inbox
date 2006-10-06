Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWJFTKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWJFTKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWJFTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:10:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62911 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1422647AbWJFTKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:10:30 -0400
Date: Fri, 6 Oct 2006 21:09:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] fix mesh compile errors after irq changes
In-Reply-To: <20061006185310.GA6757@aepfle.de>
Message-ID: <Pine.LNX.4.62.0610062108300.23747@pademelon.sonytel.be>
References: <20061002132116.2663d7a3.akpm@osdl.org>
 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
 <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
 <20061006185310.GA6757@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Olaf Hering wrote:
> drivers/scsi/mesh.c:469: error: too many arguments to function 'mesh_interrupt'
> drivers/scsi/mesh.c:507: error: too many arguments to function 'mesh_interrupt'
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  drivers/scsi/mesh.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/scsi/mesh.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/mesh.c
> +++ linux-2.6/drivers/scsi/mesh.c
> @@ -466,7 +466,7 @@ static void mesh_start_cmd(struct mesh_s
>  				dlog(ms, "intr b4 arb, intr/exc/err/fc=%.8x",
>  				     MKWORD(mr->interrupt, mr->exception,
>  					    mr->error, mr->fifo_count));
> -				mesh_interrupt(0, (void *)ms, NULL);
> +				mesh_interrupt(0, (void *)ms);
                                                  ^^^^^^^^
>  				if (ms->phase != arbitrating)
>  					return;
>  			}
> @@ -504,7 +504,7 @@ static void mesh_start_cmd(struct mesh_s
>  		dlog(ms, "intr after disresel, intr/exc/err/fc=%.8x",
>  		     MKWORD(mr->interrupt, mr->exception,
>  			    mr->error, mr->fifo_count));
> -		mesh_interrupt(0, (void *)ms, NULL);
> +		mesh_interrupt(0, (void *)ms);
                                  ^^^^^^^^
These casts are superfluous, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
