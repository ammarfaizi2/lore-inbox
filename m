Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971942-18554>; Thu, 9 Jul 1998 21:06:40 -0400
Received: from venus.star.net ([199.232.114.5]:1257 "EHLO venus.star.net" ident: "root") by vger.rutgers.edu with ESMTP id <971940-18554>; Thu, 9 Jul 1998 21:06:17 -0400
Message-ID: <35A579F3.68F549AF@star.net>
Date: Thu, 09 Jul 1998 22:18:27 -0400
From: Bill Hawes <whawes@star.net>
X-Mailer: Mozilla 4.05 [en] (WinNT; I)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: ganesh.sittampalam@magd.ox.ac.uk, "Stephen C. Tweedie" <sct@redhat.com>, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Alan Cox <number6@the-village.bc.nu>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
References: <Pine.LNX.3.96.980709182436.431F-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Linus Torvalds wrote:

> -extern inline pte_t pte_wrprotect(pte_t pte)   { pte_val(pte) &= ~_PAGE_RW; return pte; }
>  extern inline pte_t pte_rdprotect(pte_t pte)   { pte_val(pte) &= ~_PAGE_USER; return pte; }
>  extern inline pte_t pte_exprotect(pte_t pte)   { pte_val(pte) &= ~_PAGE_USER; return pte; }
>  extern inline pte_t pte_mkclean(pte_t pte)     { pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
>  extern inline pte_t pte_mkold(pte_t pte)       { pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
> -extern inline pte_t pte_mkwrite(pte_t pte)     { pte_val(pte) |= _PAGE_RW; return pte; }
>  extern inline pte_t pte_mkread(pte_t pte)      { pte_val(pte) |= _PAGE_USER; return pte; }
>  extern inline pte_t pte_mkexec(pte_t pte)      { pte_val(pte) |= _PAGE_USER; return pte; }
>  extern inline pte_t pte_mkdirty(pte_t pte)     { pte_val(pte) |= _PAGE_DIRTY; return pte; }
>  extern inline pte_t pte_mkyoung(pte_t pte)     { pte_val(pte) |= _PAGE_ACCESSED; return pte; }
> +
> +/*
> + * These are harder, as writability is two bits, not one..
> + */
> +extern inline int pte_write(pte_t pte)         { return (pte_val(pte) & _PAGE_WRITABLE) == _PAGE_WRITABLE; }
> +extern inline pte_t pte_wrprotect(pte_t pte)   { pte_val(pte) &= ~((pte_val(pte) & _PAGE_PRESENT) << 1); return pte; }
> +extern inline pte_t pte_mkwrite(pte_t pte)     { pte_val(pte) |= _PAGE_RW; return pte; }
                                                                    ^^^^^^^^
Did you mean to put in _PAGE_WRITABLE here, or can the pte_mkwrite macro always assume the
PRESENT bit is already set?

Regards,
Bill

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
