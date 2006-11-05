Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWKEMU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWKEMU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 07:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWKEMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 07:20:29 -0500
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:14609 "EHLO
	outbound3-dub-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932685AbWKEMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 07:20:28 -0500
X-BigFish: V
Subject: Re: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
From: Conke Hu <conke.hu@amd.com>
Reply-To: conke.hu@amd.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luugi Marsan <luugi.marsan@amd.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1162582216.12810.40.camel@localhost.localdomain>
References: <20061103185420.B3FA6CBD48@localhost.localdomain>
	 <1162582216.12810.40.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: AMD
Date: Sun, 05 Nov 2006 20:17:59 +0800
Message-Id: <1162729080.8525.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
X-OriginalArrivalTime: 05 Nov 2006 12:20:12.0389 (UTC) FILETIME=[BDFD0150:01C700D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 19:30 +0000, Alan Cox wrote:
> Ar Gwe, 2006-11-03 am 13:54 -0500, ysgrifennodd Luugi Marsan:
> > From: conke.hu@amd.com
> > 
> > ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID.IDE modes are used for compatibility with some old OS without AHCI driver,but now they are not necessary for Linux since the kernel has supported AHCI.Some BIOS set Legacy IDE as SB600 SATA's default mode, but the AHCI driver cannot run in Legacy IDE.So, we should set the controller back to AHCI mode if it has been set as IDE by BIOS.
> > 
> > Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>
> 
> NAK
> 
> This should only be done if AHCI is configured into the kernel, so wants
> a #ifdef check adding. Otherwise people using SB600 via the legacy ide
> layer will get burned.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Hi Alan,
    Thank you for your consideration and reply. But there seems to be
some misunderstanding.

    1. The SATA configuration option "Legacy IDE mode" (as well as
Native IDE mode) in SB600 BIOS is ONLY for old OS, and it is not useful
any longer for new Linux kernels.

    2. We could consider:
       original system BIOS + this patch == new BIOS for Linux.
    (This will not effect any other OS installed or to be installed on
SB600.)

    3. "This should only be done if AHCI is configured into the kernel,
so wants a #ifdef check adding".
    Alan, this fix should always be done whether AHCI is configured into
kernel or not, even when AHCI is not configured at all. Because:
    a). Without it, the SB600 SATA controller will appear as an IDE,
which may misguide user to try to load legacy IDE driver (or other IDE
driver). For example, if user run command "lspci" he will consider the
controller as an IDE by mistake and maybe he will try to load legacy IDE
driver (or other IDE driver).
    b). We have a RAID driver (close source) for SB600 SATA which does
not depends on the open source AHCI driver in linux kernel and supports
both AHCI and RAID. But if the controller is configured as legacy IDE by
BIOS, the RAID driver cannot run at all because of the IRQ policy. 

    4. "Otherwise people using SB600 via the legacy ide layer will get
burned." 
    Why? After kernel is fixed by this patch, is there still any legacy
ide layer or ide driver that will touch SB600 SATA controller? (the
class code has been changed to 0x010601, which tells the kernel, "I am
an AHCI 1.0 controller, not an IDE".)
   


Best regards,
Conke Hu

    

