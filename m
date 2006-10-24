Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWJXK1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWJXK1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWJXK1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:27:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:57125 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030273AbWJXK1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:27:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MMioJGZKGrxWfdQLxfvjCK9Lit7pSpzyj2kekHTjppDNrOI/rb90XGcAjdrw3SZ8jp0B8+N4mHEA4sGo/2QdMguozoidCdMR0CvrjR3RfZvHVFNvkrJ2lDGu8c7ndewyoLRF5b5p+z16PxudOfyXepvXUYvRsCeHxPwTCao/zcc=
Date: Tue, 24 Oct 2006 14:27:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH] appletalk: prevent unregister_sysctl_table() with a NULL argument
Message-ID: <20061024102711.GA27382@martell.zuzino.mipt.ru>
References: <20061024085357.GB7703@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024085357.GB7703@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 05:53:57PM +0900, Akinobu Mita wrote:
> If register_sysctl_table() fails during module initalization,
> NULL pointer dereference will happen in the module cleanup.

> --- work-fault-inject.orig/net/appletalk/sysctl_net_atalk.c
> +++ work-fault-inject/net/appletalk/sysctl_net_atalk.c
> @@ -78,5 +78,6 @@ void atalk_register_sysctl(void)
>
>  void atalk_unregister_sysctl(void)
>  {
> -	unregister_sysctl_table(atalk_table_header);
> +	if (atalk_table_header)
> +		unregister_sysctl_table(atalk_table_header);

Make sure that module won't load if sysctl table can't be registered,
instead.

