Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbTFEQmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264747AbTFEQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:42:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264746AbTFEQmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:42:07 -0400
Date: Thu, 5 Jun 2003 09:55:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: James Morris <jmorris@intercode.com.au>
Cc: patmans@us.ibm.com, akpm@digeo.com, jgarzik@pobox.com, davem@redhat.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: 2.5.70-bk+ broken networking
Message-Id: <20030605095512.022ea3be.shemminger@osdl.org>
In-Reply-To: <Mutt.LNX.4.44.0306051325110.335-100000@excalibur.intercode.com.au>
References: <20030604184341.A10256@beaverton.ibm.com>
	<Mutt.LNX.4.44.0306051325110.335-100000@excalibur.intercode.com.au>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003 13:25:58 +1000 (EST)
James Morris <jmorris@intercode.com.au> wrote:

> On Wed, 4 Jun 2003, Patrick Mansfield wrote:
> 
> > [root@elm3b79 root]# ifup eth0
> > sender address length == 0
> 
> This is a bug introduced by a coding style cleanup, fix below.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@intercode.com.au>
> 
> --- bk.pending/net/core/iovec.c	2003-06-05 11:12:59.000000000 +1000
> +++ bk.w1/net/core/iovec.c	2003-06-05 13:30:06.000000000 +1000
> @@ -47,10 +47,10 @@ int verify_iovec(struct msghdr *m, struc
>  						  address);
>  			if (err < 0)
>  				return err;
> -			m->msg_name = address;
> -		} else
> -			m->msg_name = NULL;
> -	}
> +		}
> +		m->msg_name = address;
> +	} else
> +		m->msg_name = NULL;
>  
>  	size = m->msg_iovlen * sizeof(struct iovec);
>  	if (copy_from_user(iov, m->msg_iov, size))

Thanks, this works for me.  I will see if it fixes the other gnome mystery as well.
