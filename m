Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSFARTO>; Sat, 1 Jun 2002 13:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316881AbSFARTN>; Sat, 1 Jun 2002 13:19:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2821 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316880AbSFARTM>; Sat, 1 Jun 2002 13:19:12 -0400
Date: Sat, 1 Jun 2002 14:19:02 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/16] list_head debugging
Message-ID: <20020601171902.GC14169@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF88863.BF3AF0FA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 01, 2002 at 01:40:03AM -0700, Andrew Morton escreveu:
> A common and very subtle bug is to use list_heads which aren't on any
> lists.  It causes kernel memory corruption which is observed long after
> the offending code has executed.
 
> The patch nulls out the dangling pointers so we get a nice oops at the
> site of the buggy code.

> =====================================
> 
> --- 2.5.19/include/linux/list.h~list-debug	Sat Jun  1 01:18:05 2002
> +++ 2.5.19-akpm/include/linux/list.h	Sat Jun  1 01:18:05 2002
> @@ -94,6 +94,11 @@ static __inline__ void __list_del(struct
>  static __inline__ void list_del(struct list_head *entry)
>  {
>  	__list_del(entry->prev, entry->next);

#ifdef CONFIG_DEBUG_LIST_DEL_NULLIFY

> +	entry->next = 0;
> +	entry->prev = 0;

#endif

>  }

8) And get this configured in the Debug section of make *config

The kernel will always have bugs ;)

- Arnaldo
