Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129770AbQKEKwP>; Sun, 5 Nov 2000 05:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbQKEKwF>; Sun, 5 Nov 2000 05:52:05 -0500
Received: from [62.172.234.2] ([62.172.234.2]:26263 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129770AbQKEKwA>;
	Sun, 5 Nov 2000 05:52:00 -0500
Date: Sun, 5 Nov 2000 10:52:38 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Naren Devaiah <naren@cs.pdx.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where is __this_module actually defined?
In-Reply-To: <Pine.GSO.4.21.0011050245280.2808-100000@antares.cs.pdx.edu>
Message-ID: <Pine.LNX.4.21.0011051050320.1171-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, Naren Devaiah wrote:

> 
> Does this mean that the module structure (struct module) and it's various
> substructures are filled in by insmod?
> 
> Regards,
> Naren

Yes, partially, i.e. have a look at sys_create_module() and
sys_init_module() system calls, they are in kernel/module.c

sys_create_module() just allocates the space and links the module into the
list but sys_init_module() is passed a 'struct module' from userspace
whose content is harshly validated (trust no one!) and then installed into
a real kernel 'struct module' and module's init_module() routine is
invoked.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
