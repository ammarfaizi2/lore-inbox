Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbREWEBx>; Wed, 23 May 2001 00:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262980AbREWEBn>; Wed, 23 May 2001 00:01:43 -0400
Received: from relay1.scripps.edu ([137.131.200.29]:51432 "EHLO
	relay1.scripps.edu") by vger.kernel.org with ESMTP
	id <S262979AbREWEBc>; Wed, 23 May 2001 00:01:32 -0400
Date: Tue, 22 May 2001 20:58:10 -0700 (PDT)
From: Andy Arvai <arvai@scripps.edu>
Message-Id: <200105230358.UAA14993@astra.scripps.edu>
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: noapic doesn't quite work as advertised
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a tyan s2520 motherboard (dual PIII + i840) which is having a
problem with APIC errors. I tried running with noapic, but there were
still errors, although fewer. Does anyone have any idea what is going
on? I'm running 2.4.4 and software raid5, which generates a lot of
interrupts.

Here are some of the APIC errors (with noapic):

May 21 12:38:31 rad kernel: APIC error on CPU0: 02(01)
May 21 12:42:31 rad kernel: APIC error on CPU0: 01(01)
May 21 12:42:31 rad kernel: APIC error on CPU1: 02(02)
May 21 12:43:13 rad kernel: APIC error on CPU0: 01(02)
May 21 12:43:13 rad kernel: APIC error on CPU1: 02(01)
May 21 13:48:19 rad kernel: SCSI disk error : host 3 channel 0 id 0 lun 0 return code = 8000002
May 21 13:48:19 rad kernel: [valid=0] Info fld=0x0, Current sd08:d2: sense key Aborted Command
May 21 13:48:19 rad kernel: Additional sense indicates Scsi parity error
May 21 13:48:19 rad kernel:  I/O error: dev 08:d2, sector 56590336
May 21 13:48:19 rad kernel: interrupting MD-thread pid 1223
May 21 13:48:19 rad kernel: raid5: parity resync was not fully finished, restarting next time.

Here is /proc/interrupts to prove I'm really running with noapic:

           CPU0       CPU1       
  0:   17760464          0          XT-PIC  timer
  1:      29525          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  3:   27416165          0          XT-PIC  eth1
 11:  188276091          0          XT-PIC  aic7xxx, aic7xxx, aic7xxx, aic7xxx
 12:     413496          0          XT-PIC  PS/2 Mouse
 14:    1137884          0          XT-PIC  ide0
 15:    1740847          0          XT-PIC  ide1
NMI:          0          0 
LOC:   17760053   17759969 
ERR:         31

Right now I'm running with noapic and nosmp and so far this seems to
be working. I really would like to be able to use the second
cpu so any suggestion would be greatly appreciated.

Andy
arvai@scripps.edu
