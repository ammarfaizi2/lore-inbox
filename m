Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUBHFFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 00:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUBHFFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 00:05:37 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:52419 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262123AbUBHFFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 00:05:36 -0500
Message-ID: <4025C3F0.7000804@myrealbox.com>
Date: Sat, 07 Feb 2004 21:06:56 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040207
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [2.6.1] Kernel panic with ppa driver updates
References: <fa.fsggm3p.17jmtpp@ifi.uio.no> <fa.n3claqs.1ihaob0@ifi.uio.no>
In-Reply-To: <fa.n3claqs.1ihaob0@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Feb 07, 2004 at 07:35:52PM -0800, walt wrote:

>>ppa: Version 2.07 (for Linux 2.4.x)
>>dev = dfd67940, dev->cur_cmd = 7232b2df
>>Unable to handle kernel paging request at virtual address 7232b403

> Aaaaaargh.... memset(dev, 0, sizeof(dev)); - spot the bug here...
> 
> Fix follows.  Linus, apply it, please.  Amazing that it survives in modular
> case...
> 
> diff -urN RC2-bk1-base/drivers/scsi/imm.c RC2-bk1-current/drivers/scsi/imm.c
> --- RC2-bk1-base/drivers/scsi/imm.c	Thu Feb  5 18:48:49 2004
> +++ RC2-bk1-current/drivers/scsi/imm.c	Sat Feb  7 22:44:16 2004
> @@ -1153,7 +1153,7 @@
>  	if (!dev)
>  		return -ENOMEM;
>  
> -	memset(dev, 0, sizeof(dev));
> +	memset(dev, 0, sizeof(imm_struct));
>  
>  	dev->base = -1;
>  	dev->mode = IMM_AUTODETECT;
> diff -urN RC2-bk1-base/drivers/scsi/ppa.c RC2-bk1-current/drivers/scsi/ppa.c
> --- RC2-bk1-base/drivers/scsi/ppa.c	Thu Feb  5 18:48:57 2004
> +++ RC2-bk1-current/drivers/scsi/ppa.c	Sat Feb  7 22:44:27 2004
> @@ -1010,7 +1010,7 @@
>  	dev = kmalloc(sizeof(ppa_struct), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
> -	memset(dev, 0, sizeof(dev));
> +	memset(dev, 0, sizeof(ppa_struct));
>  	dev->base = -1;
>  	dev->mode = PPA_AUTODETECT;
>  	dev->recon_tmo = PPA_RECON_TMO;
> -

Yes, it's fixed now.  Thank you!
