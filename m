Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbSKFMhV>; Wed, 6 Nov 2002 07:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265011AbSKFMhU>; Wed, 6 Nov 2002 07:37:20 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:6919 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265010AbSKFMhU>;
	Wed, 6 Nov 2002 07:37:20 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader against 2.5.46: 9/9 
In-reply-to: Your message of "Tue, 05 Nov 2002 11:47:27 +1100."
             <20021105005214.0AEAB2C237@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 23:43:40 +1100
Message-ID: <25206.1036586620@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2002 11:47:27 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>Since I believe kallsyms is important, this reimplements it sanely,
>using the current module infrastructure, and not using an external
>kallsyms script.
>
>FYI, the previous interface was:
>
>int kallsyms_symbol_to_address(
>	const char       *name,			/* Name to lookup */
>	unsigned long    *token,		/* Which module to start with */
>	const char      **mod_name,		/* Set to module name or "kernel" */
>	unsigned long    *mod_start,		/* Set to start address of module */
>	unsigned long    *mod_end,		/* Set to end address of module */
>	const char      **sec_name,		/* Set to section name */
>	unsigned long    *sec_start,		/* Set to start address of section */
>	unsigned long    *sec_end,		/* Set to end address of section */
>	const char      **sym_name,		/* Set to full symbol name */
>	unsigned long    *sym_start,		/* Set to start address of symbol */
>	unsigned long    *sym_end		/* Set to end address of symbol */
>	);
>
>The new one is:
>/* Lookup an address.  modname is set to NULL if it's in the kernel. */
>const char *kallsyms_lookup(unsigned long addr,
>			    unsigned long *symbolsize,
>			    unsigned long *offset,
>			    char **modname);

If you are going to change the interface then don't call it kallsyms.
kallsyms and that interface were designed to kernel debugging in
general and kdb in particular.  I need all the fields for decent
debugging and I refuse to allow my kallsyms code to be appropiated for
somebody else's usage if it stops kdb from working!

