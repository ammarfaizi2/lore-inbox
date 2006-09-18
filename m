Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWIRBTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWIRBTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIRBTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:19:25 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:13072 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S965209AbWIRBTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:19:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAL6PDUWBT4oRLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Om Narasimhan <om.turyx@gmail.com>
Subject: Re: kmalloc to kzalloc patches for drivers/atm
Date: Sun, 17 Sep 2006 21:19:19 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-atm-general@lists.sourceforge.net
References: <6b4e42d10609171753i63697c8et3e6e1c5706b60d5f@mail.gmail.com>
In-Reply-To: <6b4e42d10609171753i63697c8et3e6e1c5706b60d5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609172119.20555.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 September 2006 20:53, Om Narasimhan wrote:
> --- a/drivers/atm/firestream.c
> +++ b/drivers/atm/firestream.c
> @@ -1784,7 +1784,7 @@ static int __devinit fs_init (struct fs_
>                 write_fs (dev, RAM, (1 << (28 - FS155_VPI_BITS - FS155_VCI_BITS)) - 1);
>                 dev->nchannels = FS155_NR_CHANNELS;
>         }
> -       dev->atm_vccs = kmalloc (dev->nchannels * sizeof (struct atm_vcc *),
> +       dev->atm_vccs = kzalloc (dev->nchannels * sizeof (struct atm_vcc *),
>                                  GFP_KERNEL);
>         fs_dprintk (FS_DEBUG_ALLOC, "Alloc atmvccs: %p(%Zd)\n",
>                     dev->atm_vccs, dev->nchannels * sizeof (struct atm_vcc *));
> 

kcalloc would be better here because you are allocating several objects
at once.

-- 
Dmitry
