Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAZAQN>; Thu, 25 Jan 2001 19:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129334AbRAZAQD>; Thu, 25 Jan 2001 19:16:03 -0500
Received: from expanse.dds.nl ([194.109.10.118]:42756 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129172AbRAZAPy>;
	Thu, 25 Jan 2001 19:15:54 -0500
Date: Fri, 26 Jan 2001 01:15:38 +0100
From: Ookhoi <ookhoi@dds.nl>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia delay causes bootp not to work
Message-ID: <20010126011538.X21704@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010126000007.U21704@ookhoi.dds.nl> <Pine.LNX.4.30.0101252310370.2734-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
In-Reply-To: <Pine.LNX.4.30.0101252310370.2734-100000@imladris.demon.co.uk>; from dwmw2@infradead.org on Thu, Jan 25, 2001 at 11:11:09PM +0000
X-Uptime: 5:14pm  up 56 days,  6:26, 24 users,  load average: 0.00, 0.04, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> Er... no, don't try that patch. It'll oops. Try this instead.
> 
> --- drivers/pcmcia/yenta.c	2000/12/05 13:30:42	1.1.2.23
> +++ drivers/pcmcia/yenta.c	2001/01/25 23:10:35
> @@ -859,7 +859,8 @@
>  	socket->tq_task.data = socket;
>  
>  	MOD_INC_USE_COUNT;
> -	schedule_task(&socket->tq_task);
> +	//	schedule_task(&socket->tq_task);
> +	yenta_open_bh(socket);
>  
>  	return 0;
>  }

Thank you. :-)  Unfortunately, the bootp message "IP-Config: No network
devices available." still comes before the initialisation of the network
card, and thus the nf mount still failes. :-(

(this is with a clean untarred linux tree, edit and compile, and I
double checked the change in drivers/pcmcia/yenta.c)

Is there an other way to initialize the nic before bootp kickes in?

		Ookhoi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
