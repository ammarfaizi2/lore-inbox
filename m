Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbUCZMtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUCZMtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:49:39 -0500
Received: from magic.adaptec.com ([216.52.22.17]:30642 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S264079AbUCZMt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:49:27 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.3 gdth driver NMI Watchdog detected LOCKUP
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 26 Mar 2004 13:49:24 +0100
Message-ID: <B51CDBDEB98C094BB6E1985861F53AF302DD6E@nkse2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3 gdth driver NMI Watchdog detected LOCKUP
Thread-Index: AcQSpXD3fmT6NXBpRN2nNZdRDDl7qgAiq4KA
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Florian Lohoff" <flo@rfc822.org>, <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for reporting this problem. I will include the change into our new driver version and will send a patch for 2.6.4 on Monday next week to Linus.

Achim Leubner
Research & Development
ICP vortex Computersysteme GmbH
Gostritzer Str. 61-63
D-01217 Dresden, Germany
Phone: +49-351-871-8291
Fax: +49-351-871-8448
Email: achim_leubner@adaptec.com
Web: www.icp-vortex.com 


> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Florian
> Lohoff
> Sent: Donnerstag, 25. März 2004 21:05
> To: linux-kernel@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Subject: 2.6.3 gdth driver NMI Watchdog detected LOCKUP
> 
> 
> Hi,
> i got this NMI on one of our Machines - I have seen these kinds of deadlocks
> on 2.4 too - Iirc its a locking problem on long overdue requests and the scsi_eh
> kicking in. I think i spotted this already in 2.4.18 back in May 2002 (Mail attached).
> 
> Dual PIII 1Ghz, Serverworks Chipset, ICP Vortex
> Vanilla 2.6.3
> 
> 00:05.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT 6123RS/6523RS
>         Subsystem: ICP Vortex Computersysteme GmbH GDT 6123RS/6523RS
>         Flags: bus master, medium devsel, latency 32, IRQ 18
>         Memory at fe000000 (32-bit, prefetchable) [size=16K]
>         Expansion ROM at <unassigned> [disabled] [size=32K]
>         Capabilities: [80] Power Management version 2
> 
> Adapter 0: Host Drive 0: resetted locally
> Adapter 0: Host Drive 0: resetted locally
> NMI Watchdog detected LOCKUP on CPU0, eip c0116e24, registers:
> CPU:    0
> EIP:    0060:[<c0116e24>]    Not tainted
> EFLAGS: 00000083
> EIP is at delay_tsc+0x14/0x20
> eax: 52bff37b   ebx: 000f0b90   ecx: 52b42ab1   edx: 00006b5a
> esi: c00981c0   edi: 00000000   ebp: 00000002   esp: f7fabe8c
> ds: 007b   es: 007b   ss: 0068
> Process scsi_eh_2 (pid: 18, threadinfo=f7faa000 task=f7dc6c00)
> Stack: ffffffff c01eade2 000f0b90 c0261ffd 000f0b90 0001734e c026258a 00000001
>        c00981c0 00000000 00000000 c009ae80 c00981c0 00000002 00000000 c02626e0
>        00000000 00000002 000186a0 000186a0 00000018 09000000 00000000 c00981c0
> Call Trace:
>  [<c01eade2>] __delay+0x12/0x20
>  [<c0261ffd>] gdth_delay+0x2d/0x60
>  [<c026258a>] gdth_wait+0x6a/0xc0
>  [<c02626e0>] gdth_internal_cmd+0x100/0x1e0
>  [<c026582c>] gdth_eh_bus_reset+0x24c/0x2c0
>  [<c024e456>] scsi_try_bus_reset+0x56/0xf0
>  [<c024b7e4>] __scsi_iterate_devices+0x84/0xa0
>  [<c024e639>] scsi_eh_bus_reset+0x59/0xf0
>  [<c024eb80>] scsi_eh_ready_devs+0x50/0x80
>  [<c024ed20>] scsi_unjam_host+0xe0/0xf0
>  [<c024ee28>] scsi_error_handler+0xf8/0x150
>  [<c024ed30>] scsi_error_handler+0x0/0x150
>  [<c0108c19>] kernel_thread_helper+0x5/0xc
> 
> Code: 29 c8 39 d8 72 f6 5b c3 8d 74 26 00 55 b8 00 e0 ff ff 57 56
> console shuts up ...
>  EIP is at __preempt_spin_lock+ 0x50/0x70
> 
> 
> 
> 
> I guess modifying "gdth_polling" needs to be move infront of taking the
> lock and needs to be guranteed written out to mem (memory barrier ?
> atomic_set ?)
> 
> drivers/scsi/gdth.c:gdth_eh_bus_reset
> 
>    4779
>    4780     if (b == ha->virt_bus) {
>    4781         /* host drives */
>    4782         for (i = 0; i < MAX_HDRIVES; ++i) {
>    4783             if (ha->hdr[i].present) {
>    4784                 GDTH_LOCK_HA(ha, flags);
>    4785                 gdth_polling = TRUE;
>    4786                 while (gdth_test_busy(hanum))
>    4787                     gdth_delay(0);
>    4788                 if (gdth_internal_cmd(hanum, CACHESERVICE,
>    4789                                       GDT_CLUST_RESET, i, 0, 0))
>    4790                     ha->hdr[i].cluster_type &= ~CLUSTER_RESERVED;
>    4791                 gdth_polling = FALSE;
>    4792                 GDTH_UNLOCK_HA(ha, flags);
>    4793             }
>    4794         }
>    4795     } else {
>    4796         /* raw devices */
>    4797         GDTH_LOCK_HA(ha, flags);
>    4798         for (i = 0; i < MAXID; ++i)
>    4799             ha->raw[BUS_L2P(ha,b)].io_cnt[i] = 0;
>    4800         gdth_polling = TRUE;
>    4801         while (gdth_test_busy(hanum))
>    4802             gdth_delay(0);
>    4803         gdth_internal_cmd(hanum, SCSIRAWSERVICE, GDT_RESET_BUS,
>    4804                           BUS_L2P(ha,b), 0, 0);
>    4805         gdth_polling = FALSE;
>    4806         GDTH_UNLOCK_HA(ha, flags);
>    4807     }
>    4808     return SUCCESS;
>    4809 }
>    4810
> 
> vs.
> 
> drivers/scsi/gdth.c:gdth_interrupt
> 
>    3390     if (!gdth_polling)
>    3391         GDTH_LOCK_HA((gdth_ha_str *)dev_id,flags);
>    3392     wait_index = 0;
> 
> So we have a small race.
> 
> I would propose something like this:
> 
> 
> --- linux-2.6.3/drivers/scsi/gdth.c.orig	2004-03-25 20:58:18.000000000 +0100
> +++ linux-2.6.3/drivers/scsi/gdth.c	2004-03-25 20:59:28.000000000 +0100
> @@ -4781,29 +4781,29 @@
>          /* host drives */
>          for (i = 0; i < MAX_HDRIVES; ++i) {
>              if (ha->hdr[i].present) {
> -                GDTH_LOCK_HA(ha, flags);
>                  gdth_polling = TRUE;
> +                GDTH_LOCK_HA(ha, flags);
>                  while (gdth_test_busy(hanum))
>                      gdth_delay(0);
>                  if (gdth_internal_cmd(hanum, CACHESERVICE,
>                                        GDT_CLUST_RESET, i, 0, 0))
>                      ha->hdr[i].cluster_type &= ~CLUSTER_RESERVED;
> -                gdth_polling = FALSE;
>                  GDTH_UNLOCK_HA(ha, flags);
> +                gdth_polling = FALSE;
>              }
>          }
>      } else {
>          /* raw devices */
> +        gdth_polling = TRUE;
>          GDTH_LOCK_HA(ha, flags);
>          for (i = 0; i < MAXID; ++i)
>              ha->raw[BUS_L2P(ha,b)].io_cnt[i] = 0;
> -        gdth_polling = TRUE;
>          while (gdth_test_busy(hanum))
>              gdth_delay(0);
>          gdth_internal_cmd(hanum, SCSIRAWSERVICE, GDT_RESET_BUS,
>                            BUS_L2P(ha,b), 0, 0);
> -        gdth_polling = FALSE;
>          GDTH_UNLOCK_HA(ha, flags);
> +        gdth_polling = FALSE;
>      }
>      return SUCCESS;
>  }
> 
> 
> --
> Florian Lohoff                  flo@rfc822.org             +49-171-2280134
>                         Heisenberg may have been here.
