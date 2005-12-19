Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVLSOef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVLSOef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVLSOef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:34:35 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:21136 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750988AbVLSOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:34:35 -0500
Subject: Re: [patch 15/15] Generic Mutex Subsystem, arch-semaphores.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219014043.GK28038@elte.hu>
References: <20051219014043.GK28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:34:06 -0500
Message-Id: <1135002846.13138.258.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:40 +0100, Ingo Molnar wrote:
> Index: linux/drivers/acpi/osl.c
> ===================================================================
> --- linux.orig/drivers/acpi/osl.c
> +++ linux/drivers/acpi/osl.c
> @@ -728,14 +728,14 @@ void acpi_os_delete_lock(acpi_handle han
>  acpi_status
>  acpi_os_create_semaphore(u32 max_units, u32 initial_units,
> acpi_handle * handle)
>  {
> -       struct semaphore *sem = NULL;
> +       struct arch_semaphore *sem = NULL;
>  
>         ACPI_FUNCTION_TRACE("os_create_semaphore");
>  
> -       sem = acpi_os_allocate(sizeof(struct semaphore));
> +       sem = acpi_os_allocate(sizeof(struct arch_semaphore));

[OT]
This is why I prefer sizeof(*sem) over sizeof(struct type_of_sem) but I
regress.  And I don't buy that argument of the mistaken sizeof(sem)
since, I've never had to deal with that bug!  Oh well, each to their
own.

-- Steve

>         if (!sem)
>                 return_ACPI_STATUS(AE_NO_MEMORY);
> -       memset(sem, 0, sizeof(struct semaphore));
> +       memset(sem, 0, sizeof(struct arch_semaphore));
>  
>         sema_init(sem, initial_units);

