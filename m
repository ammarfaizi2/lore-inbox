Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRABIOi>; Tue, 2 Jan 2001 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRABIO2>; Tue, 2 Jan 2001 03:14:28 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:6446 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129561AbRABIOM>;
	Tue, 2 Jan 2001 03:14:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: start___kallsyms missing from i386 vmlinux.lds ? 
In-Reply-To: Your message of "Tue, 02 Jan 2001 01:56:08 CDT."
             <3A517B88.13523C37@yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jan 2001 18:43:35 +1100
Message-ID: <26475.978421415@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2001 01:56:08 -0500, 
Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
>--- linux/arch/i386/vmlinux.lds~	Fri Jul  7 03:47:07 2000
>+++ linux/arch/i386/vmlinux.lds	Mon Jan  1 07:55:50 2001
>+  __start___kallsyms = .;	/* All kernel symbols */
>+  __kallsyms : { *(__kallsyms) }
>+  __stop___kallsyms = .;

kernel/module.c defines 
extern const char __start___kallsyms[] __attribute__ ((weak));
extern const char __stop___kallsyms[] __attribute__ ((weak));

The symbols are weak and do not need to be defined.  If gcc is not
honouring __attribute__ ((weak)) then you have a broken or obsolete
version of gcc.  You need at least gcc 2.91.66 for kernel 2.4.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
