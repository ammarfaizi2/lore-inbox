Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWIJXNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWIJXNn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWIJXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 19:13:43 -0400
Received: from 1wt.eu ([62.212.114.60]:31506 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964807AbWIJXNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 19:13:43 -0400
Date: Mon, 11 Sep 2006 01:08:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Dieter Ferdinand <dieter.ferdinand@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: total system crash
Message-ID: <20060910230823.GE541@1wt.eu>
References: <45049D46.5225.57F41B4A@dieter.ferdinand.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45049D46.5225.57F41B4A@dieter.ferdinand.gmx.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 11:18:30PM +0000, Dieter Ferdinand wrote:
> hello,
> i have some big problems with kernel 2.4.32.
> 
> i use asterisk as pbx with an avm b1-card and capi on a dual p3-500 
> system. this system crash always if i make a call from isdn to asterisk and 
> from asterisk to isdn dependently which end hangs up first.
> 
> i test same on an other system with an avm fritz-card without problem.
> the test on a system with single cpu is in planning.

Could you please test 2.4.34-pre2 ?
There was a recent fix for avm-b1 c4 cards causing problems with Pentium3.
I'm not sure at all it is related, but it might be worth trying.

> the next problem makes more problems and i need this driver.
> i use adaptec scsi-controllers (aha 2940 and other models with the same 
> driver) in all my scsi-systems.
> 
> after some problems with the scsi-system, the system hangs total.
> i have only the log at the end of the mail and here are some informations 
> missing.
> 
> this system crash thre time today with the same error. after booting with 
> kernel 2.6.16.27 i get a message soft-lookup detected and system hangs.
> the system is very much swapping at this moment.
> 
> this system is a pentium 266 with an ide-harddisk for linux and two scsi-
> harddisks for backup und data. i use this system for testing new kernels and 
> software.
> 
> it looks that i have this problem only on heavy load and many paging-
> requests.

I would suggest that you carefully check your cables and terminations. From
experience, the 2940 is very sensible to incorrect termination and loosy
cables. Also, you might have some SCSI devices which do not support the
speed you have set.

> if you need more informations, i think, i can reproduce this errors every time 
> if i start some programs which makes a high system load.

It might also be possible that you have an old buggy PCI chipset on this
machine, which was not uncommon at times of P2/266.

> but i don't know, how i can catch informations, which you need, to solve this 
> problem.
> i can setup a remote-login to the system for you without access to my other 
> system-resources.

Well, a remote login will not provide anything more, unfortunately. First,
you have to check that every piece of hardware is correct, and that your
PCI settings in the BIOS are OK.

> the next problem is with kernel 2.4 and 2.6. i have some older pentium dual-
> systems with intel hx-chipset. on this systems, both kernel crash after some 
> time, i think the most time on heavy system load. kernel 2.2 works fine with 
> this systems.

maybe 2.2 puts less stress on the hardware ?

> i can accecpt, that a scsi-device is deaktivated, if there are some errors, but 
> i can't accecpt, that the system crash and hangs.

To be fair, Linux's SCSI stack has always been fragile for me. In many
situations, hardware errors have caused my system to hang. I believe that
SCSI in 2.6 is slightly more robust, but I've not played much with it.

> goodby

Regards,
Willy

> Sep 10 09:23:12 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
> SCB
> Sep 10 09:23:12 p-266 (scsi0:A:5:0): Abort Message Sent
> Sep 10 09:23:12 p-266 (scsi0:A:5:0): SCB 3 - Abort Completed.
> Sep 10 09:23:12 p-266 scsi0:0:5:0: Attempting to queue a TARGET RESET 
> message
> Sep 10 09:23:12 p-266 scsi0:0:5:0: Command not found
> Sep 10 09:23:22 p-266 scsi0:0:5:0: Attempting to queue an ABORT 
> message
> Sep 10 09:23:22 p-266 scsi0: At time of recovery, card was not paused
> Sep 10 09:23:22 p-266 scsi0: Dumping Card State while idle, at SEQADDR 
> 0x8
> Sep 10 09:23:22 p-266 SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
> LASTPHASE[0x1]:(P_BUSFREE) 
> Sep 10 09:23:22 p-266 SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
> SBLKCTL[0x2]:(SELWIDE) 
> Sep 10 09:23:22 p-266 SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
> SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
> Sep 10 09:23:22 p-266 SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
> SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
> Sep 10 09:23:22 p-266 0 
> SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
> SCB_SCSIID[0x57] 
> Sep 10 09:23:22 p-266 1 
> SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
> SCB_SCSIID[0x57] 
> Sep 10 09:23:22 p-266 2 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 3 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 4 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 5 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 6 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 7 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 8 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 9 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 10 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 11 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 12 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 13 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 14 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 15 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:22 p-266 4 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) 
> SCB_SCSIID[0x57] SCB_LUN[0x0] 
> Sep 10 09:23:22 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
> SCB
> Sep 10 09:23:22 p-266 (scsi0:A:5:0): Abort Message Sent
> Sep 10 09:23:22 p-266 (scsi0:A:5:0): SCB 4 - Abort Completed.
> Sep 10 09:23:37 p-266 scsi0:0:5:0: Attempting to queue an ABORT 
> message
> Sep 10 09:23:37 p-266 scsi0: At time of recovery, card was not paused
> Sep 10 09:23:37 p-266 scsi0: Dumping Card State while idle, at SEQADDR 
> 0x8
> Sep 10 09:23:37 p-266 SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
> LASTPHASE[0x1]:(P_BUSFREE) 
> Sep 10 09:23:37 p-266 SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
> SBLKCTL[0x2]:(SELWIDE) 
> Sep 10 09:23:37 p-266 SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
> SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
> Sep 10 09:23:37 p-266 SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
> SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
> Sep 10 09:23:37 p-266 0 
> SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
> SCB_SCSIID[0x57] 
> Sep 10 09:23:37 p-266 1 
> SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
> SCB_SCSIID[0x57] 
> Sep 10 09:23:37 p-266 2 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 3 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 4 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 5 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 6 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 7 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 8 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 9 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 10 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 11 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 12 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 13 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 14 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 15 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:37 p-266 3 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) 
> SCB_SCSIID[0x57] SCB_LUN[0x0] 
> Sep 10 09:23:37 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
> SCB
> Sep 10 09:23:37 p-266 (scsi0:A:5:0): Abort Message Sent
> Sep 10 09:23:37 p-266 (scsi0:A:5:0): SCB 3 - Abort Completed.
> Sep 10 09:23:37 p-266 scsi: device set offline - not ready or command retry 
> failed after bus reset: host 0 channel 0 id 5 lun 0
> Sep 10 09:23:47 p-266 scsi0:0:5:0: Attempting to queue an ABORT 
> message
> Sep 10 09:23:47 p-266 scsi0: At time of recovery, card was not paused
> Sep 10 09:23:47 p-266 scsi0: Dumping Card State while idle, at SEQADDR 
> 0x8
> Sep 10 09:23:47 p-266 SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
> LASTPHASE[0x1]:(P_BUSFREE) 
> Sep 10 09:23:47 p-266 SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
> SBLKCTL[0x2]:(SELWIDE) 
> Sep 10 09:23:47 p-266 SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
> SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
> Sep 10 09:23:47 p-266 SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
> SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
> Sep 10 09:23:47 p-266 0 
> SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
> SCB_SCSIID[0x57] 
> Sep 10 09:23:47 p-266 1 
> SCB_CONTROL[0xc8]:(ULTRAENB|DISCENB|TARGET_SCB) 
> SCB_SCSIID[0x57] 
> Sep 10 09:23:47 p-266 2 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 3 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 4 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 5 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 6 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 7 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 8 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 9 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 10 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 11 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 12 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 13 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 14 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 15 SCB_CONTROL[0x0] 
> SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
> Sep 10 09:23:47 p-266 4 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) 
> SCB_SCSIID[0x57] SCB_LUN[0x0] 
> Sep 10 09:23:47 p-266 (scsi0:A:5:0): Device is disconnected, re-queuing 
> SCB
> Sep 10 09:23:47 p-266 (scsi0:A:5:0): Abort Message Sent
> Sep 10 09:23:47 p-266 (scsi0:A:5:0): SCB 4 - Abort Completed.
> Sep 10 09:23:47 p-266 scsi: device set offline - not ready or command retry 
> failed after bus reset: host 0 channel 0 id 5 lun 0
> Sep 10 09:23:47 p-266 SCSI disk error : host 0 channel 0 id 5 lun 0 return 
> code = 30000
> Sep 10 09:23:47 p-266 SCSI disk error : host 0 channel 0 id 5 lun 0 return 
> code = 30000
> 
> Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
> Dort findest du Information zu Linux, Novell, Win95, WinNT, ...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
