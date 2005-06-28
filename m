Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVF1VyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVF1VyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVF1Vwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:52:50 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:18449 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261326AbVF1Vvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:51:41 -0400
Date: Tue, 28 Jun 2005 23:51:48 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, akpm@osdl.org,
       tytso@mit.edu, zwane@arm.linux.org.uk, jmforbes@linuxtx.org,
       rdunlap@xenotime.net, torvalds@osdl.org, chuckw@quantumlinux.com,
       alan@lxorguk.ukuu.org.uk, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow
 board initialization.
Message-Id: <20050628235148.4512d046.khali@linux-fr.org>
In-Reply-To: <20050627225349.GK9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	<20050627225349.GK9046@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, all,

> -stable review patch.  If anyone has any objections, please let us
> know.

I have. This one patch is rather big and parts of it don't seem to
belong to -stable. Can't it be simplified? More below.

> Return to previous held-logic of calling scsi_add_host() only
> after the board has been completely initialized.

What real bug is it supposed to fix? (I guess some, but this leading
comment should give the datails.)

> Also return pci_*() error-codes during probe failure paths.

How does this belong to stable please? I don't see this fixing any
critical bug.

> This also corrects an issue where only lun 0 is being scanned for
> a given port.

This OTOH is probably OK.

> -	if (ret != 0) {
> -		goto probe_alloc_failed;
> -	}
> +	if (ret)
> +		goto probe_failed;

This change can be made smaller.

> -	if (ret != 0) {
> +	if (ret) {

This aint -stable material.

Thanks,
-- 
Jean Delvare
