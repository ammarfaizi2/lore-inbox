Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKFB3y>; Sun, 5 Nov 2000 20:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQKFB3o>; Sun, 5 Nov 2000 20:29:44 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:39979 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129195AbQKFB3g>; Sun, 5 Nov 2000 20:29:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: Your message of "Mon, 06 Nov 2000 00:54:51 -0000."
             <Pine.LNX.4.21.0011060050030.11842-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 12:28:49 +1100
Message-ID: <2508.973474129@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000 00:54:51 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Mon, 6 Nov 2000, Keith Owens wrote:
>
>> I'm not sure why you think this can be used for module persistent
>> storage.  If a module calls inter_module_register() on load, it should
>> call inter_module_unregister() on unload.  All the registered data
>> points into the loaded module, remove the module and the storage
>> disappears as well.
>
>You can kmalloc() both the im_name and userdata arguments to
>inter_module_register and you ought to be able to pass NULL as the owner.

Ughh!  That is definitely abusing the inter_module functions.  If we
need persistent module storage then we should add a clean interface to
do it instead of using kmalloc and overloading inter_module_xxx.

What do people think, do we need module persistent storage?  There are
already entries in struct module for persistent data but there is no
way of setting those fields, nor is there any code in modutils to
handle persistent storage.  This will probably be a 2.5 change but I
want to get an idea of the requirements before coding anything.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
