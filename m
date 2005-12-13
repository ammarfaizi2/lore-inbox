Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVLMP2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVLMP2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVLMP2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:28:25 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:43849 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964985AbVLMP2Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:28:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2mNzUKaabIz9Ij7OxtIA9Vn1AYdM7hVKkidUuZ2dCpS83oSyjifeCcRRErtPjzCjbjTQQyz+FJ5w3bzrHj/WITClX4ij0mxGxEV6MsMmGbbEokMGTnj5wl0aN8wcrSMVujvLAVsQ4rQOwirLAyTe+e49WM3Rs0nLt2xdKcxVGw=
Message-ID: <81083a450512130728l230ee858s85185a74efc91956@mail.gmail.com>
Date: Tue, 13 Dec 2005 20:58:23 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: anandhkrishnan@yahoo.co.in, linux-kernel@vger.kernel.org, rth@redhat.com,
       akpm@osdl.org, Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
> On 12/13/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > How about something like:
> >
> >         const struct kernel_symbol *sym;
> >         unsigned int i;
> >         const unsigned long *crc;
> >         struct module *owner;
> >
> >         spin_lock_irq(&modlist_lock);
> >         for (i = 0; i < mod->num_syms; i++)
> >                 if (__find_symbol(mod->syms[i].name, &owner, &crc, 1))
> >                         goto dup;
> >         for (i = 0; i < num->num_gpl_syms; i++)
> >                 if (__find_symbol(mod->gpl_syms[i].name,&owner,&crc,1))
> >                         goto dup;
> >         spin_unlock_irq(&modlist_lock);
> >         return 0;
> > dup:
> >         printk("%s: exports duplicate symbol (owned by %s)\n",
> >                 mod->name, module_name(owner));
> >         return -ENOEXEC;
> > }
>
> Have tried that in the attached patch. However,  mod->syms[i].name
> would be valid only after a long relocation for loop has run through.
> While this adds a wee bit extra overhead, that overhead is only in the
> case where the module does actually export a Duplicate Symbol.

Forgot to add
Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
Signed-off-by: Anand Krishnan <anandhkrishnan@yahoo.co.in>

Cheers
