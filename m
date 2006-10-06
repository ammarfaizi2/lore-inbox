Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWJFK4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWJFK4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWJFK4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:56:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16041 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751467AbWJFK4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:56:09 -0400
Subject: Re: [PATCH 4/5] ioremap balanced with iounmap for
	drivers/char/rio/rio_linux.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1160110628.19143.89.camel@amol.verismonetworks.com>
References: <1160110628.19143.89.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 12:21:55 +0100
Message-Id: <1160133715.1607.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-06 am 10:27 +0530, ysgrifennodd Amol Lad:
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
>  rio_linux.c |    3 +++
>  1 files changed, 3 insertions(+)
> ---
> diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/rio/rio_linux.c linux-2.6.19-rc1/drivers/char/rio/rio_linux.c
> --- linux-2.6.19-rc1-orig/drivers/char/rio/rio_linux.c	2006-10-05 14:00:43.000000000 +0530
> +++ linux-2.6.19-rc1/drivers/char/rio/rio_linux.c	2006-10-05 14:50:00.000000000 +0530
> @@ -1181,6 +1181,9 @@ static void __exit rio_exit(void)
>  		}
>  		/* It is safe/allowed to del_timer a non-active timer */
>  		del_timer(&hp->timer);
> +
> +		if (hp->Caddr)
> +			iounmap(hp->Caddr);
>  	}

I don't think this is sufficient because it may be unmapped earlier on
error but hp->Caddr is not then cleared .

