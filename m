Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291563AbSBAGLk>; Fri, 1 Feb 2002 01:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291565AbSBAGLa>; Fri, 1 Feb 2002 01:11:30 -0500
Received: from zok.sgi.com ([204.94.215.101]:28545 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291563AbSBAGLQ>;
	Fri, 1 Feb 2002 01:11:16 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: garzik@havoc.gtf.org, alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Thu, 31 Jan 2002 22:01:21 -0800."
             <20020131.220121.39157969.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 17:11:05 +1100
Message-ID: <7245.1012543865@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 22:01:21 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Keith Owens <kaos@ocs.com.au>
>   Date: Fri, 01 Feb 2002 16:10:13 +1100
>   
>   As long as Makefiles control initialization order, you need monolithic
>   Makefiles.
>
>With the current 2.5.x scheme, you can put your init into the
>appropriate group.  Makefiles only control init order within
>the groups.

But you still need monolithic makefiles.

They also control order across directories as well, including up one,
down two constructs like this.

obj-$(CONFIG_SCSI_AHA1740)      += aha1740.o
ifeq ($(CONFIG_SCSI_AIC7XXX),y)
obj-$(CONFIG_SCSI_AIC7XXX)      += aic7xxx/aic7xxx_drv.o
endif
obj-$(CONFIG_SCSI_AIC7XXX_OLD)  += aic7xxx_old.o

and the abomination

obj-$(CONFIG_SCSI_LASI700)      += lasi700.o 53c700.o

subdir-$(CONFIG_ARCH_ACORN)     += ../acorn/scsi
obj-$(CONFIG_ARCH_ACORN)        += ../acorn/scsi/acorn-scsi.o

obj-$(CONFIG_CHR_DEV_ST)        += st.o

BTW, the grouped initcalls in the code are exactly what I proposed in
October 2000 and was shouted down.  Except my proposal would have put
all the initialization order information together, instead of putting
some information in the source and some in the Makefiles.  It is now
even harder to see the precise order, you have to check which type of
initcall each source is using in addition to scanning the makefile
order.

