Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQJaOaE>; Tue, 31 Oct 2000 09:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbQJaO3r>; Tue, 31 Oct 2000 09:29:47 -0500
Received: from ns.dce.bg ([212.50.14.242]:3595 "HELO home.dce.bg")
	by vger.kernel.org with SMTP id <S129069AbQJaO3l>;
	Tue, 31 Oct 2000 09:29:41 -0500
Message-ID: <39FED73C.A4BA630D@dce.bg>
Date: Tue, 31 Oct 2000 16:29:16 +0200
From: Petko Manolov <petkan@dce.bg>
Organization: Deltacom Electronics
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: changed section attributes
In-Reply-To: <16848.973001732@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> >Changing the declaration in linux/module.h to ".modinfo,"a""
> >fixed the problem, but i noticed that the author said that
> >"we want .modinfo to not be allocated"
> 
> Historically that was the only way of preventing the .modinfo section
> from being included in modules when they were loaded into the kernel.
> An alternative is to allow .modinfo to be allocated and have modutils
> treat it as non-allocated.  This feature was added to modutils 2.3.19
> on October 22 (bleeding edge toolchains for IA64 are "fun") so anybody
> who is annoyed by the warning messages can apply this patch.

[snip]
 
> -/* The attributes of a section are set the first time the section is
> -   seen; we want .modinfo to not be allocated.  */
> -
> -__asm__(".section .modinfo\n\t.previous");
> -
>  /* Define the module variable, and usage macros.  */
>  extern struct module __this_module;


This is exactly what i did (excluding removing of the comment ;-)

I wonder why the compiler decides to add ".section
.modinfo,"a",@progbits"
May be this is the thing which should be fixed.


	Petkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
