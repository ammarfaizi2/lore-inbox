Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWFXVrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWFXVrn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFXVrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:47:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751101AbWFXVrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:47:41 -0400
Date: Sat, 24 Jun 2006 14:47:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
Message-Id: <20060624144739.78bde590.akpm@osdl.org>
In-Reply-To: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 13:36:28 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=6745
> 
>            Summary: kernel hangs when trying to read atip wiith cdrecord
>     Kernel Version: 2.6.16.1
>             Status: NEW
>           Severity: normal
>              Owner: bzolnier@gmail.com
>          Submitter: lohmaier@gmx.de
> 
> 
> Most recent kernel where this bug did not occur: 2.6.16.1 (yes, the same version
> - it works with my dvd-burner, but not with my cd-burner), the 2.4 series worked
> with both, but there I have been using ide-scsi)
> Distribution: Mandriva 9.0 based
> Hardware Environment:
> cdrom: Cyberdrive CW058D - master on 2nd IDE
> dvd: Pioneer 106D slave on prim. IDE
> MB: elitegroup k7sem with sis chipset (SIS 5513)
> Software Environment:
> cdrtools 2.01.01a10
> 
> Problem Description:
> When trying to use cdrecord with the cdburner, the kernel hangs (not completely,
> only for cd-burning) and the system has to be rebooted. Even retrieving the
> atip-information of a disc fails.
> It fails only with the cd-recorder, not with the DVD-Burner. But when I tried
> with the cdrecorder, burning with the dvd-burner won't work either until the
> machine is rebooted.
> 
> Steps to reproduce:
> I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
> # cdrecord dev=ATAPI:1,0,0 -atip
> Cdrecord-ProDVD-Clone 2.01.01a09 (i686-pc-linux-gnu) Copyright (C) 1995-2006
> J&#65533;rg Schilling
> cdrecord: Warning: Running on Linux-2.6.16.1
> cdrecord: There are unsettled issues with Linux-2.5 and newer.
> cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
> scsidev: 'ATAPI:1,0,0'
> devname: 'ATAPI'
> scsibus: 1 target: 0 lun: 0
> Warning: Using ATA Packet interface.
> Warning: The related Linux kernel interface code seems to be unmaintained.
> Warning: There is absolutely NO DMA, operations thus are slow.
> Using libscg version 'schily-0.8'.
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 1
> Vendor_info    : 'CyberDrv'
> Identifikation : 'CW058D CD-R/RW  '
> Revision       : '160D'
> Device seems to be: Generic mmc CD-RW.
> Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
> Driver flags   : MMC-2 SWABAUDIO BURNFREE
> Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P
> RAW/R96R
> ----here it hangs and never returns---
> 
> If I run cdrecord with -V (i.e. scsi verbose), it reads:
> [...]
> Executing 'mode select g1' command on Bus 1 Target 0, Lun 0 timeout 40s
> CDB:  55 10 00 00 00 00 00 00 3C 00
> cmd finished after 0.002s timeout 40s
> 
> Executing 'get_configuration' command on Bus 1 Target 0, Lun 0 timeout 40s
> CDB:  46 02 00 37 00 00 00 00 10 00
> cmd finished after 0.000s timeout 40s
> 
> Executing 'read buffer' command on Bus 1 Target 0, Lun 0 timeout 40s
> CDB:  3C 00 00 00 00 00 00 00 04 00
> cmd finished after 0.000s timeout 40s
> 
> Executing 'read buffer' command on Bus 1 Target 0, Lun 0 timeout 40s
> CDB:  3C 00 00 00 00 00 00 FC 00 00
> 
> So the kernel doesn't timeout/return for some reason.
> You can find the full log here:
> http://muenchen-surf.de/lohmaier/cdrecord_atip_log
> 
> If that information is not enough to handle the process, please tell me what
> else you need. Thank you.
> 

We seem to have an awful lot of these "CD burner doesn't work but it did in
2.4" reports.

Does anyone have the vaguest inklink of how we broke it?
