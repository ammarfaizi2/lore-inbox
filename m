Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTBBRAV>; Sun, 2 Feb 2003 12:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbTBBRAV>; Sun, 2 Feb 2003 12:00:21 -0500
Received: from mail.ithnet.com ([217.64.64.8]:2061 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264956AbTBBRAU>;
	Sun, 2 Feb 2003 12:00:20 -0500
Date: Sun, 2 Feb 2003 18:09:38 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.21-pre4: tg3 driver problems with shared interrupts
Message-Id: <20030202180938.0d265c2c.skraw@ithnet.com>
In-Reply-To: <3E3D4C08.2030300@pobox.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Feb 2003 11:49:12 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Stephan von Krawczynski wrote:
> > I found out within minutes that this setup does not survive if you let the
> > Broadcom cards share interrupts with anything else. It works ok now like
> > this (eth2 is tg3):
> 
> [...]
> > But horribly failed in such a setup:
> 
> [...]
> > I cannot even produce a "cat /proc/interrupts" for this because I am not fast
> > enough at login (the network at eth2 is heavy loaded). I sometimes read about
> > problems here with tg3-drivers, and I just wanted to point you to the shared
> > case, maybe it has to do with this special case rather than with the drivers
> > internals itself.
> > (PS: its not the ide2-3, I checked that out)
> 
> 
> 
> hmmm.  I've attached the latest tg3, version 1.4, which I just sent off 
> to Marcelo.  It includes some fixes that may affect your 5701.

Sorry, putting it into pre4 results in:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre4-patch/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=tg3  -c -o tg3.o tg3.c
tg3.c:140: `PCI_DEVICE_ID_TIGON3_5704S' undeclared here (not in a function)
tg3.c:140: initializer element is not constant
tg3.c:140: (near initialization for `tg3_pci_tbl[8].device')
tg3.c:141: initializer element is not constant
tg3.c:141: (near initialization for `tg3_pci_tbl[8]')
tg3.c:142: `PCI_DEVICE_ID_TIGON3_5702A3' undeclared here (not in a function)
tg3.c:142: initializer element is not constant
tg3.c:142: (near initialization for `tg3_pci_tbl[9].device')
tg3.c:143: initializer element is not constant
tg3.c:143: (near initialization for `tg3_pci_tbl[9]')
tg3.c:144: `PCI_DEVICE_ID_TIGON3_5703A3' undeclared here (not in a function)
tg3.c:144: initializer element is not constant
tg3.c:144: (near initialization for `tg3_pci_tbl[10].device')
tg3.c:145: initializer element is not constant
tg3.c:145: (near initialization for `tg3_pci_tbl[10]')
tg3.c:147: initializer element is not constant
tg3.c:147: (near initialization for `tg3_pci_tbl[11]')
tg3.c:149: initializer element is not constant
tg3.c:149: (near initialization for `tg3_pci_tbl[12]')
tg3.c:151: initializer element is not constant
tg3.c:151: (near initialization for `tg3_pci_tbl[13]')
tg3.c:152: initializer element is not constant
tg3.c:152: (near initialization for `tg3_pci_tbl[14]')
make[3]: *** [tg3.o] Error 1

Shall I patch it, or do you?

-- 
Regards,
Stephan
