Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVILQ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVILQ5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVILQ5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:57:06 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6364 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932092AbVILQ5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:57:05 -0400
Message-ID: <4325B2EB.70701@austin.ibm.com>
Date: Mon, 12 Sep 2005 11:55:07 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: serue@us.ibm.com
CC: Alan Cox <alan@redhat.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: tty patches in 2.6.13-mm3 (was Re: 2.6.13-mm1)
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com> <43176AE8.8060105@austin.ibm.com> <20050901211647.GC25405@devserv.devel.redhat.com> <431771EA.4030809@austin.ibm.com> <20050901214411.GD25405@devserv.devel.redhat.com> <20050912163432.GA6119@sergelap.austin.ibm.com>
In-Reply-To: <20050912163432.GA6119@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure whether these are going in through some other channel,
> but I notice neither the Alan's hvcs.c or icom.c patches are in
> 2.6.13-mm3.  In addition, hvc_console.c needs yet another...

Yeah, there is still a whole lot broken in -mm.  Your patch below is a 
good start though.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>

> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> Index: linux-2.6.12/drivers/char/hvc_console.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/char/hvc_console.c	2005-09-12 15:08:41.000000000 -0500
> +++ linux-2.6.12/drivers/char/hvc_console.c	2005-09-12 15:52:08.000000000 -0500
> @@ -597,7 +597,7 @@ static int hvc_poll(struct hvc_struct *h
>  
>  	/* Read data if any */
>  	for (;;) {
> -		count = tty_buffer_request_room(tty, N_INBUF);
> +		int count = tty_buffer_request_room(tty, N_INBUF);
>  
>  		/* If flip is full, just reschedule a later read */
>  		if (count == 0) {
> @@ -633,7 +633,7 @@ static int hvc_poll(struct hvc_struct *h
>  			tty_insert_flip_char(tty, buf[i], 0);
>  		}
>  
> -		if (tty->flip.count)
> +		if (tty_buffer_request_room(tty, 1))
>  			tty_schedule_flip(tty);
>  
>  		/*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

