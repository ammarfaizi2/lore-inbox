Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSGPQAx>; Tue, 16 Jul 2002 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSGPQAw>; Tue, 16 Jul 2002 12:00:52 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:57282 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S317872AbSGPQAv>; Tue, 16 Jul 2002 12:00:51 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac6
Date: Tue, 16 Jul 2002 18:08:20 +0200
X-Mailer: KMail [version 1.3.2]
References: <200207161345.g6GDjAW24698@devserv.devel.redhat.com>
In-Reply-To: <200207161345.g6GDjAW24698@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020716160051Z317872-685+10612@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 July 2002 15:45, Alan Cox wrote:
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
>
> Linux 2..419rc1-ac6
> o       Update merge using bits from newer summit diff  (James Cleverdon)
> o       Fix problems with non SMP but io-apic build     (me)
> o       Socket error path memory leak fix               (Robert Love)
> o       Fix sd_varyio masks for higher drives           (Kurt Garloff)
> o       Fix tmpfs double kunmap                         (Hugh Dickins)
> o       VIA rhine cleanup/fixes                         (Roger Luethi)
> o       Fix typos in ncr/seagate scsi                   (James Mayer)
> o       MPT fusion update                               (Pam Delaney)
> o       Trident audio code cleanups and lock fixes      (Muli Ben-Yehuda)
> o       Fix irq balancing for summit boxes with Ingo's  (James Cleverdon)
>         PIV balancer

did the folowing:
make mrproper
put .config back
make oldconfig

and then I got these questions:
  default tagged command queue depth (CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS) [8] 
(NEW)
  maximum number of queued commands (CONFIG_SCSI_NCR53C8XX_MAX_TAGS) [32] 
(NEW)
  synchronous transfers frequency in MHz (CONFIG_SCSI_NCR53C8XX_SYNC) [20] 
(NEW)
  enable profiling (CONFIG_SCSI_NCR53C8XX_PROFILE) [N/y/?] (NEW)
  use normal IO (CONFIG_SCSI_NCR53C8XX_IOMAPPED) [N/y/?] (NEW)
  assume boards are SYMBIOS compatible (EXPERIMENTAL) 
(CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT) [N/y/?] (NEW)

this is strange because CONFIG_SCSI_NCR53C8XX and CONFIG_SCSI_SYM53C8XX are 
not set and CONFIG_SCSI_ZALON does not exist in my .config
so this condition in drivers/scsi/Config.in (line 156) should not be true:
   if [ "$CONFIG_SCSI_NCR53C8XX" != "n" -o "$CONFIG_SCSI_ZALON" != "n" -o 
"$CONFIG_SCSI_SYM53C8XX" != "n" ]; then

when I add CONFIG_SCSI_ZALON to my .config (after CONFIG_SCSI_SYM53C8XX) then 
these questions are not asked.
CONFIG_SCSI_ZALON is missing from my .config because it depends on CONFIG_GSC 
and CONFIG_SCSI and I can't find where CONFIG_GSC is set...

a possible solution would be to check whether $CONFIG_SCSI_ZALON = y or n

	Rudmer
