Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTEWM5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTEWM5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:57:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:9268 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264060AbTEWM5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:57:25 -0400
Message-ID: <3ECE1DBF.5090602@gmx.net>
Date: Fri, 23 May 2003 15:10:23 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell Coker <russell@coker.com.au>
Subject: Re: Linux 2.4.21-rc3
References: <Pine.LNX.4.44.0305231437260.28118-100000@cam029208.student.utwente.nl>
In-Reply-To: <Pine.LNX.4.44.0305231437260.28118-100000@cam029208.student.utwente.nl>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martijn Uffing wrote:
> Ave
> 
> Modular ide is still broken in 2.4.21-rc3  with my config.

IIRC, Alan said it is not suposed to work yet. However, if you're
feeling brave (and have no valuable data), you can try to export these
symbols to make depmod happy. (Please read on)

> "make modules_install" gives a:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-disk.o
> depmod: 	proc_ide_read_geometry
> depmod: 	ide_remove_proc_entries
> depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-probe.o
> depmod: 	do_ide_request
> depmod: 	ide_add_generic_settings
> depmod: 	create_proc_ide_interfaces
> depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide.o
> depmod: 	ide_release_dma
> depmod: 	ide_add_proc_entries
> depmod: 	cmd640_vlb
> depmod: 	ide_probe_for_cmd640x
> depmod: 	ide_scan_pcibus
> depmod: 	proc_ide_read_capacity
> depmod: 	proc_ide_create
> depmod: 	ide_remove_proc_entries
> depmod: 	destroy_proc_ide_drives
> depmod: 	proc_ide_destroy
> depmod: 	create_proc_ide_interfaces
> 
> 
> The .config of these errors.
> 
> CONFIG_IDE=m
> CONFIG_BLK_DEV_IDE=m
> CONFIG_BLK_DEV_IDEDISK=m
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_CMD640=y
> CONFIG_BLK_DEV_RZ1000=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_VIA82CXXX=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y

Alan? It might be prudent to make all IDE CONFIG_XYZ bools for -rc4 so
no one can complain that the released kernel does not compile. Marcelo
could just revert it for 2.4.22-pre then.

This is mainly to keep the complaint level down.


Regards,
Carl-Daniel

