Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUCGV2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 16:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUCGV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 16:28:50 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37050 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262338AbUCGV2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 16:28:48 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jakub Bogusz <qboosh@pld-linux.org>
Subject: Re: (2.6 IDE) why PDC202XX_FORCE not allowed with BLK_DEV_PDC202XX_NEW=m?
Date: Sun, 7 Mar 2004 22:36:12 +0100
User-Agent: KMail/1.5.3
References: <20040307210701.GA23440@satan.blackhosts>
In-Reply-To: <20040307210701.GA23440@satan.blackhosts>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403072236.12019.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Please use linux-ide@vger.kernel.org for IDE issues. ]

On Sunday 07 of March 2004 22:07, Jakub Bogusz wrote:
> PDC202XX_FORCE option is needed to override controller disable by BIOS
> when RAID is used. Or maybe there is another way to do this in 2.6.x?

Nope.

> This option has "depends on BLK_DEV_PDC202XX_NEW=y" flag in
> drivers/ide/Kconfig, thus is not available with pdc202xx_new in
> module - why?

It seems like a leftover from non-modular IDE PCI days.

> I saw success report with modular pdc202xx_new after this simple change
> (without PDC202XX_FORCE controller ports were not detected):
>
> --- linux/drivers/ide/Kconfig.orig        2004-03-04 07:16:45.000000000
> +0100 +++ linux/drivers/ide/Kconfig     2004-03-07 17:37:25.000000000 +0100
> @@ -720,7 +720,7 @@
>  # FIXME - probably wants to be one for old and for new
>  config PDC202XX_FORCE
>         bool "Enable controller even if disabled by BIOS"
> -       depends on BLK_DEV_PDC202XX_NEW=y
> +       depends on BLK_DEV_PDC202XX_NEW
>         help
>           Enable the PDC202xx controller even if it has been disabled in
> the BIOS setup.
>
>
> The same may apply to PDC202XX_BURST for pdc202xx_old module...
> (but not tested)

Yes, you are right.

Thanks,
Bartlomiej

