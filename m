Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318402AbSHBKdG>; Fri, 2 Aug 2002 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318403AbSHBKdG>; Fri, 2 Aug 2002 06:33:06 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:54485 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318402AbSHBKdF>; Fri, 2 Aug 2002 06:33:05 -0400
Message-ID: <3D4A6090.AA67CB08@wanadoo.fr>
Date: Fri, 02 Aug 2002 12:36:00 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac4 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 does not build cleanly
References: <3D4A40C3.AF47AA62@wanadoo.fr> <20020802090831.GB1055@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

TU for the tip but I still have one unresolved symbol :

make[3]: Leaving directory `/usr/src/kernel-source-2.5.30/arch/i386/pci'
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/usr/src/linux/debian/tmp-image -r 2.5.30; fi
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/arch/i386/kernel/apm.o
depmod: 	cpu_gdt_table
make[2]: *** [_modinst_post] Erreur 1
make[2]: Leaving directory `/usr/src/kernel-source-2.5.30'
make[1]: *** [real_stamp_image] Erreur 2

-----
regards
	Jean-Luc

Jens Axboe wrote:
> 
> On Fri, Aug 02 2002, Jean-Luc Coulon wrote:
> > Hi,
> >
> > I get the following messages :
> >
> > make[3]: Leaving directory `/usr/src/kernel-source-2.5.30/arch/i386/pci'
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
> > /usr/src/linux/debian/tmp-image -r 2.5.30; fi
> > depmod: *** Unresolved symbols in
> > /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/arch/i386/kernel/apm.o
> > depmod:       cpu_gdt_table
> > depmod: *** Unresolved symbols in
> > /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/block/floppy.o
> > depmod:       elv_queue_empty
> > depmod: *** Unresolved symbols in
> > /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/block/nbd.o
> > depmod:       elv_queue_empty
> > depmod: *** Unresolved symbols in
> > /usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/scsi/scsi_mod.o
> > depmod:       elv_queue_empty
> > make[2]: *** [_modinst_post] Erreur 1
> > make[2]: Leaving directory `/usr/src/kernel-source-2.5.30'
> > make[1]: *** [real_stamp_image] Erreur 2
> 
> fixes the elv_queue_empty one
> 
> --- linux/drivers/block/elevator.c~     2002-08-02 11:07:33.000000000 +0200
> +++ linux/drivers/block/elevator.c      2002-08-02 11:07:49.000000000 +0200
> @@ -482,5 +482,6 @@
>  EXPORT_SYMBOL(__elv_add_request);
>  EXPORT_SYMBOL(elv_next_request);
>  EXPORT_SYMBOL(elv_remove_request);
> +EXPORT_SYMBOL(elv_queue_empty);
>  EXPORT_SYMBOL(elevator_exit);
>  EXPORT_SYMBOL(elevator_init);
> 
> --
> Jens Axboe
