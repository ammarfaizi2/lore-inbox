Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272238AbTHNIxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 04:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHNIxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 04:53:49 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:19707 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272238AbTHNIxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 04:53:48 -0400
Subject: Re: [PATCH] ide: limit drive capacity to 137GB if host doesn't
	support LBA48
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308140324.45524.bzolnier@elka.pw.edu.pl>
References: <200308140324.45524.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 09:53:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 02:24, Bartlomiej Zolnierkiewicz wrote:
>  	hwif->rqsize			= old_hwif.rqsize;
> -	hwif->addressing		= old_hwif.addressing;
> +	hwif->no_lba48			= old_hwif.no_lba48;

This change is a bad idea. Its called "addressing" because that is what
it is about (see SATA and ATA specs). In future SATA addressing becomes
a 0,1,2 value because 48bits isnt enough, it may get more forms beyond
that.

Might be worth defining ADDR_LBA48, ADDR_LBA28 etc to make it clearer,
but really people shouldnt be randomly hacking IDE code without having
read the specifications.

