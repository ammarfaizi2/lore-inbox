Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTFEDSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTFEDSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:18:04 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:13574 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264463AbTFEDRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:17:52 -0400
Date: Thu, 5 Jun 2003 00:32:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: James Morris <jmorris@intercode.com.au>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.5.70-bk+ broken networking
Message-ID: <20030605033208.GK24515@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	James Morris <jmorris@intercode.com.au>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Andrew Morton <akpm@digeo.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20030604184341.A10256@beaverton.ibm.com> <Mutt.LNX.4.44.0306051325110.335-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0306051325110.335-100000@excalibur.intercode.com.au>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the curious, it was introduced in changeset 1.1259.9.18

- Arnaldo

Em Thu, Jun 05, 2003 at 01:25:58PM +1000, James Morris escreveu:
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
> 
