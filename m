Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWADSzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWADSzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbWADSzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:55:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15626 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965267AbWADSze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:55:34 -0500
Date: Wed, 4 Jan 2006 19:55:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: anil dahiya <ak_ait@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: makefile for 2.6 kernel
Message-ID: <20060104185524.GA8296@mars.ravnborg.org>
References: <20060104182356.14925.qmail@web60217.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104182356.14925.qmail@web60217.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 10:23:56AM -0800, anil dahiya wrote:
> hello 
> I want to make kernel module dummy.ko using multiple
> .c and .h files. In short i am telling .c and .h files
> with directory structure
> 
> 1> dummy.ko should made be using module1.ko and
> module2.o (i.e 
>    module2.o uses module1.ko to make dummy.ko)

You cannot make a module with a module as input.
It does not make sense.
Either you create a module or you don't.

So you will create following modules:
module1.ko + module2.ko

Alternatively you create one module but using the individual .o files as
input which is more likely what you want - correct?

Then your Kbuild file would look like this:

Kbuild:
obj-m := dummy.o
dummy-y := module1/a1/a1.o
dummy-y += module1/a2/a2.o
dummy-y += module2/b1/b1.o

# Tell where to find .h files
EXTRA_CFLAGS := -I$(src)/include

And to compile your module:
make -C $PATH_TO_KERNEL_SRC M=`pwd`


I assume you already read Documentation/kbuild/modules.txt - otherwise
please do so too.

Please include the source or provide an URL to the src if you need more
help.

	Sam



> 
> 2> module1.ko made using a1/a1.c & a2/a2.c and  both
> .c file   
>    use /home/include/a.h 
> 3> module2.o should made using b/b1.c which use   
>    use /home/module2/include/b.h 
> 
> Suggest me tht should make i make module2.o or
> module2.ko and then combine it with module1.o to make
> dummy.ko 
> 
> 
> /home/------
>              |_ include _
>              |           |
>              |           a.h 
>              | 
>              |___module1_
>              |           |__ a1 ____
>              |           |          | 
>              |           |         a1.c 
>              |           |
>                          |__ a2 ____
>              |           |           | 
>              |           |         a2.c 
>              |
>              |___ moudule2_
>              |             |             
>              |             |__include _
>              |             |           |
>              |             |           b.h 
>              |             |___b1__
>              |                     | 
>              |                   b1.c 
>         
>                                    
> Looking forward for ur reply 
> thanks in advance
> ---- Anil 
> 
> 
> 		
> __________________________________________ 
> Yahoo! DSL ? Something to write home about. 
> Just $16.99/mo. or less. 
> dsl.yahoo.com 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
