Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130255AbRAKEJY>; Wed, 10 Jan 2001 23:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbRAKEJO>; Wed, 10 Jan 2001 23:09:14 -0500
Received: from marine.sonic.net ([208.201.224.37]:52824 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S130255AbRAKEJA>;
	Wed, 10 Jan 2001 23:09:00 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010110200841.B12593@sonic.net>
Date: Wed, 10 Jan 2001 20:08:41 -0800
From: David Hinds <dhinds@sonic.net>
To: Thiago Rondon <maluco@mileniumnet.com.br>, dahinds@users.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.21.0101101623150.4170-100000@freak.mileniumnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0101101623150.4170-100000@freak.mileniumnet.com.br>; from Thiago Rondon on Wed, Jan 10, 2001 at 04:24:21PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 04:24:21PM -0200, Thiago Rondon wrote:
> 
> Check kmalloc().
> 
> -Thiago Rondon
> 
> --- linux-2.4.0-ac5/drivers/pcmcia/ds.c	Sat Sep  2 04:13:49 2000
> +++ linux-2.4.0-ac5.maluco/drivers/pcmcia/ds.c	Wed Jan 10 16:20:53 2001
> @@ -414,6 +414,8 @@
>      /* Add binding to list for this socket */
>      driver->use_count++;
>      b = kmalloc(sizeof(socket_bind_t), GFP_KERNEL);
> +    if (!b) 
> +      return -ENOMEM;    
>      b->driver = driver;
>      b->function = bind_info->function;
>      b->instance = NULL;
> 

As with the other kmalloc patch, this is also broken; things have been
done that need to be un-done, and you can't just exit the function
here.  I'll come up with a better fix.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
