Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbULKTPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbULKTPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbULKTPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:15:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261998AbULKTPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:15:44 -0500
Message-ID: <41BB475B.1000202@pobox.com>
Date: Sat, 11 Dec 2004 14:15:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clear.Zhang@uli.com.tw
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andrebalsa@mailingaddress.org, Peer.Chen@uli.com.tw,
       Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw
Subject: Re: [patch] scsi/libata: correct bug for ULi M5281
References: <OF518056F7.FB1438A8-ON48256F64.0024A22B@uli.com.tw>
In-Reply-To: <OF518056F7.FB1438A8-ON48256F64.0024A22B@uli.com.tw>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clear.Zhang@uli.com.tw wrote:
> Hi, Jeff
> 
> The sata_uli patch for m5281 looks fine,but some of M5281 chip's PHY
> is not stable sometime, so it need a workaround to correct the bug.
> 
> patch_M5281workaround is just for it.
> 
> The patch is applied to kernel 2.6.9. Pleases apply to new kernels, thanks
> a lot.
> 
> Signed-off-by: Clear Zhang <Clear.Zhang@uli.com.tw>

I'm afraid I must reject this patch.  We do not wish to put
hardware-specific workarounds in libata-core.c or libata-scsi.c.

I would suggest either
(a) finding a way to add the workaround to sata_uli.c, or
(b) finding the "root cause" of the problem, and determine why the
libata code is insufficient.

Two suggestions I have while investigating your problem:
1) Replacing the ->phy_reset() hook may allow you to solve the problem
in sata_uli.c.
2) It is entirely possible that we need to add additional error handling
code to libata, including hooks back into the low-level driver (such as
sata_uli.c).

Regards,

	Jeff


