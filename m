Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313995AbSDQA5o>; Tue, 16 Apr 2002 20:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313992AbSDQA5b>; Tue, 16 Apr 2002 20:57:31 -0400
Received: from zok.sgi.com ([204.94.215.101]:63706 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S313991AbSDQA4G>;
	Tue, 16 Apr 2002 20:56:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8 
In-Reply-To: Your message of "Tue, 16 Apr 2002 09:46:09 MST."
             <Pine.LNX.4.33.0204160911200.848-100000@segfault.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Apr 2002 10:55:49 +1000
Message-ID: <21520.1019004949@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002 09:46:09 -0700 (PDT), 
Patrick Mochel <mochel@osdl.org> wrote:
>One issue that I encountered along the way was arch/i386/kernel/Makefile. 
>I found that you can't easily build multiple targets in the same 
>directory, and have dependencies for one target in subdirectories. 
>Typically, target objects have one or the other. 
>
>In order to make this work, I had to do:
>
>-all: kernel.o head.o init_task.o
>+all: first_rule kernel.o head.o init_task.o
>
>...
>
>+kernel-subdir-$(CONFIG_PCI)    += pci
>+subdir-y                       := $(kernel-subdir-y)
>+obj-y                          += $(foreach dir,$(subdir-y),$(dir)/$(dir).o)
>
>
>The last part is decent, but the explicit dependency on the first_rule 
>target is kinda gross. Is there a better way to do this? Will kbuild 2.5 
>make this nicer?

Much nicer.

arch/i386/kernel/Makefile.in

link_subdirs(pci ...)
select(head.o init_task.o)

arch/i386/kernel/pci/Makefile.in

select(foo.o bar.o)

