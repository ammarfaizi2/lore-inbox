Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWKENlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWKENlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWKENlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:41:16 -0500
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:57777 "EHLO
	outbound1-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932614AbWKENlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:41:15 -0500
X-BigFish: V
Subject: Re: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
From: Conke Hu <conke.hu@amd.com>
Reply-To: conke.hu@amd.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, Luugi Marsan <luugi.marsan@amd.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162730726.31873.15.camel@localhost.localdomain>
References: <20061103185420.B3FA6CBD48@localhost.localdomain>
	 <1162582216.12810.40.camel@localhost.localdomain>
	 <1162729080.8525.49.camel@localhost.localdomain>
	 <1162730726.31873.15.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: AMD
Date: Sun, 05 Nov 2006 21:38:54 +0800
Message-Id: <1162733934.8525.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
X-OriginalArrivalTime: 05 Nov 2006 13:41:06.0780 (UTC) FILETIME=[0B6E49C0:01C700E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 12:45 +0000, Alan Cox wrote:
> Ar Sul, 2006-11-05 am 20:17 +0800, ysgrifennodd Conke Hu:
> >     1. The SATA configuration option "Legacy IDE mode" (as well as
> > Native IDE mode) in SB600 BIOS is ONLY for old OS, and it is not useful
> > any longer for new Linux kernels.
> 
> Some users choose to use old drivers for the feeling of security and
> reduction of change. Remember there are users out there who have to go
> through a formal verification process to switch the driver they use.
> 
  Consider that the behavior itself of using the new motherboard, SB600,
means a lot of change, so even if the user still use IDE driver, he also
a need verification process.

> >     3. "This should only be done if AHCI is configured into the kernel,
> > so wants a #ifdef check adding".
> >     Alan, this fix should always be done whether AHCI is configured into
> > kernel or not, even when AHCI is not configured at all. Because:
> >     a). Without it, the SB600 SATA controller will appear as an IDE,
> > which may misguide user to try to load legacy IDE driver (or other IDE
> 
> This is not neccessarily misguided. They may want to do this.
  But the SB600 SATA controller is really an AHCI controller. And that
will lose high performance (and cannot use NCQ).

> 
> >     b). We have a RAID driver (close source) for SB600 SATA 
> 
> Thats your problem. Some day the lawyers can find out just how legal
> that is.
  No, even if there would be a open source RAID driver, it still could
no run.

> 
> You are right that most users will want to use the AHCI layer and that
> if AHCI is compiled in then we should switch to AHCI. In the case the
> kernel has no AHCI support compiled in the legacy driver support should
> continue to work for it. This is how other vendors products such as
> Jmicron are handled.
> 
  The case of Jmicron is not the same as ours. They use different pci
functions in the SATA controller.

> NAK reasserted.
  OK, I am rewriting the patch based on the following considerations:
  1. move these code to ahci driver, and add new code to PATA driver.
  2. add new options to kernel configuration, and users can choose IDE
driver or AHCI driver to support SB600 SATA when it is in IDE mode.
  

> Alan
> 
At last, thank you again for your opinions and suggestion. if any other
advice, please feel free to contact me.


Best regards,
Conke Hu


