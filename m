Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSHBJFF>; Fri, 2 Aug 2002 05:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSHBJFF>; Fri, 2 Aug 2002 05:05:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36586 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318757AbSHBJFE>;
	Fri, 2 Aug 2002 05:05:04 -0400
Date: Fri, 2 Aug 2002 11:08:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 does not build cleanly
Message-ID: <20020802090831.GB1055@suse.de>
References: <3D4A40C3.AF47AA62@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4A40C3.AF47AA62@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02 2002, Jean-Luc Coulon wrote:
> Hi,
> 
> I get the following messages :
> 
> make[3]: Leaving directory `/usr/src/kernel-source-2.5.30/arch/i386/pci'
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
> /usr/src/linux/debian/tmp-image -r 2.5.30; fi
> depmod: *** Unresolved symbols in
> /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/arch/i386/kernel/apm.o
> depmod: 	cpu_gdt_table
> depmod: *** Unresolved symbols in
> /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/block/floppy.o
> depmod: 	elv_queue_empty
> depmod: *** Unresolved symbols in
> /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/block/nbd.o
> depmod: 	elv_queue_empty
> depmod: *** Unresolved symbols in
> /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/scsi/scsi_mod.o
> depmod: 	elv_queue_empty
> make[2]: *** [_modinst_post] Erreur 1
> make[2]: Leaving directory `/usr/src/kernel-source-2.5.30'
> make[1]: *** [real_stamp_image] Erreur 2

fixes the elv_queue_empty one

--- linux/drivers/block/elevator.c~	2002-08-02 11:07:33.000000000 +0200
+++ linux/drivers/block/elevator.c	2002-08-02 11:07:49.000000000 +0200
@@ -482,5 +482,6 @@
 EXPORT_SYMBOL(__elv_add_request);
 EXPORT_SYMBOL(elv_next_request);
 EXPORT_SYMBOL(elv_remove_request);
+EXPORT_SYMBOL(elv_queue_empty);
 EXPORT_SYMBOL(elevator_exit);
 EXPORT_SYMBOL(elevator_init);

-- 
Jens Axboe

