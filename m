Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUFFRjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUFFRjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFFRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:39:42 -0400
Received: from may.priocom.com ([213.156.65.50]:42686 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263864AbUFFRjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:39:40 -0400
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
	cs46xx_dsp_proc_register_scb_desc()
From: Yury Umanets <torque@ukrpost.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040606102048.1b05c172.rddunlap@osdl.org>
References: <1086537990.2793.68.camel@firefly>
	 <20040606102048.1b05c172.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1086543608.2793.103.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 20:40:08 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 20:20, Randy.Dunlap wrote:
> On Sun, 06 Jun 2004 19:06:42 +0300 Yury Umanets wrote:
> 
> | Adds memory allocation checks in cs46xx_dsp_proc_register_scb_desc()
> | 
> |  ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c |    3 +++
> |  1 files changed, 3 insertions(+)
> | 
> | diff -rupN ./linux-2.6.6/sound/pci/cs46xx/dsp_spos_scb_lib.c
> | ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c
> | --- ./linux-2.6.6/sound/pci/cs46xx/dsp_spos_scb_lib.c	Mon May 10
> | 05:33:20 2004
> | +++ ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c	Wed Jun 
> | 2 14:57:41 2004
> | @@ -246,6 +246,9 @@ void cs46xx_dsp_proc_register_scb_desc (
> |  		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name,
> |  							ins->proc_dsp_dir)) != NULL) {
> |  			scb_info = kmalloc(sizeof(proc_scb_info_t), GFP_KERNEL);
> | +			if (!scb_info)
> | +				return;
> | +                                
> |  			scb_info->chip = chip;
> |  			scb_info->scb_desc = scb;
> |        
> 
> This seems to be missing some other cleanup on the failure path,
> like it does below in the same function:
> 
> 				snd_info_free_entry(entry);
oops, you're right. Thanks Randy. Will fix that.

> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
umka

