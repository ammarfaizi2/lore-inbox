Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289670AbSBJPGd>; Sun, 10 Feb 2002 10:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSBJPGX>; Sun, 10 Feb 2002 10:06:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55570 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289670AbSBJPGM>; Sun, 10 Feb 2002 10:06:12 -0500
Subject: Re: 2.5.4-pre5 fails to build (sounddrivers.o/pcmcia_net.o)
To: pierre.rousselet@wanadoo.fr (Pierre Rousselet)
Date: Sun, 10 Feb 2002 15:19:29 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alessandro.suardi@oracle.com (Alessandro Suardi),
        linux-kernel@vger.kernel.org, zab@zabbo.net
In-Reply-To: <3C65E916.9000306@wanadoo.fr> from "Pierre Rousselet" at Feb 10, 2002 04:29:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZvlJ-0003md-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> es1370.c is using pci_alloc_consistent. However insmod es1370 gives this 
> message :
> /lib/modules/2.5.4-pre5/kernel/drivers/sound/es1370.o: unresolved symbol 
> virt_to_bus_not_defined_use_pci_map_R2278fef8
> 
> It comes from a workaround for the "phantom write" bug. A workaround for 
> the workaround might be in this case isa_virt_to_bus

Thats actually a real bug (2.4 included) the bugbuf should be allocated
as part of the pci_alloc_consistent space. 2.4 also wants fixing for this
problem since if es1370 is modular bugbuf is vmalloc and virt_to_bus won't
do the right thing
