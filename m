Return-Path: <linux-kernel-owner+w=401wt.eu-S933195AbWLaQ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbWLaQ35 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 11:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933196AbWLaQ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 11:29:57 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40762 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933195AbWLaQ34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 11:29:56 -0500
X-Sasl-enc: aCKOIeS8wYRuHWO/gkiKouSzQp5dSCMPVIkFeyLYQ8/9 1167582485
Date: Sun, 31 Dec 2006 14:29:51 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       ibm-acpi-devel@lists.sourceforge.net, Whoopie <whoopie79@gmx.net>
Subject: Re: [PATCH] Add Ultrabay support for the T60p Thinkpad
Message-ID: <20061231162951.GA13022@khazad-dum.debian.net>
References: <E1GtH0P-0007WV-Q5@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GtH0P-0007WV-Q5@candygram.thunk.org>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoopie from ThinkWiki just sent me an email, calling my attention to the
fact that the patch you submitted is in fact different from the one I
merged... something I should have triple-verified.  It appears the t60p has
the bay in a different ACPI node than some other *60 ThinkPads.  Either
that, or the node moves depending on ICHR mode set in the BIOS.

So I apologise for the screw up, and:

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

I am merging your patch into the ibm-acpi tree and will ask Len to push it
to Linus.  Now, please excuse me while I go look for a new brown-paperbag
hat...

On Sun, 10 Dec 2006, Theodore Ts'o wrote:
> Add Ultrabay Support for the T60p Thinkpad
> 
> The following patch adds support for obtaining the status and ejecting
> Ultrabay devices for the T60p Thinkpad; my guess is that it probably
> works on T60 Thinkpads and probably more recent Lenovo latops as well.
> 
> With the 2.03 BIOS I have been able to eject a SATA drive in an Ultrabay
> carrier by using the command:
> 
>   "echo 1 > /sys/class/scsi_device/1:0:0:0/device/delete"
> 
> and upon re-inserting the it back into the device and issuing the
> command:
> 
>  "echo 0 0 0 > /sys/class/scsi_host/host1/scan"
> 
> have the device appear again.  (With the 1.02 BIOS the device does not
> function when re-inserted, even after a warm boot; a cold reboot is
> required to store the Ultrabay device's functionality.)
> 
> More complicated Ultrabay eject and insert scripts can be found on the
> ThinkWiki, although it's important to comment out the "hdparm -Y" as it
> apparently doesn't work or do anything, and causes the eject process to
> hang for about a minute.
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> Index: 2.6.19/drivers/acpi/ibm_acpi.c
> ===================================================================
> --- 2.6.19.orig/drivers/acpi/ibm_acpi.c	2006-12-09 18:35:09.000000000 -0500
> +++ 2.6.19/drivers/acpi/ibm_acpi.c	2006-12-09 18:35:42.000000000 -0500
> @@ -169,6 +169,7 @@
>  #endif
>  IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
>  	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
> +	   "\\_SB.PCI0.IDE0.PRIM.MSTR",	/* T60p */
>  	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
>      );				/* A21e, R30, R31 */
>  

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
