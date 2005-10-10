Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVJJQ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVJJQ67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVJJQ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:58:59 -0400
Received: from [81.2.110.250] ([81.2.110.250]:35533 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750942AbVJJQ67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:58:59 -0400
Subject: Re: [PATCH2 2/6] isicom: Type conversion and variables deletion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051009194201.2E69222AEAC@anxur.fi.muni.cz>
References: <20051009194201.2E69222AEAC@anxur.fi.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Oct 2005 18:27:24 +0100
Message-Id: <1128965244.11234.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-10-09 at 21:42 +0200, Jiri Slaby wrote:
> Type conversion and variables deletion
> 
> Type which is needed to have accurate size was converted to [us]{8,16}.
> Removed from void* cast.

>  static unsigned char *tmp_buf;
> -static DECLARE_MUTEX(tmp_buf_sem);

Unrelated change
 

> -	unsigned char		isa;
> +	u16			base;
> +	u8			irq;
> +	u8			port_count;
> +	u16			status;
> +	u16			port_status; /* each bit for each port */
> +	u16			shift_count;
> +	struct isi_port		*ports;
> +	s8			count;
> +	u8			isa;

These don't need to be changed and base should in fact be unsigned long
for portability.

>  	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
>  	unsigned long		flags;
>  };
>  
>  struct	isi_port {
> -	unsigned short		magic;
> +	u16			magic;

Ditto


> -		port->xmit_buf = (unsigned char *) page;
> +		port->xmit_buf = (u8*) page;

tty buffers are specifically unsigned char

