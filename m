Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUFFRZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUFFRZX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFFRZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:25:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:51648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263847AbUFFRZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:25:18 -0400
Date: Sun, 6 Jun 2004 10:20:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yury Umanets <torque@ukrpost.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
 cs46xx_dsp_proc_register_scb_desc()
Message-Id: <20040606102048.1b05c172.rddunlap@osdl.org>
In-Reply-To: <1086537990.2793.68.camel@firefly>
References: <1086537990.2793.68.camel@firefly>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004 19:06:42 +0300 Yury Umanets wrote:

| Adds memory allocation checks in cs46xx_dsp_proc_register_scb_desc()
| 
|  ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c |    3 +++
|  1 files changed, 3 insertions(+)
| 
| diff -rupN ./linux-2.6.6/sound/pci/cs46xx/dsp_spos_scb_lib.c
| ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c
| --- ./linux-2.6.6/sound/pci/cs46xx/dsp_spos_scb_lib.c	Mon May 10
| 05:33:20 2004
| +++ ./linux-2.6.6-modified/sound/pci/cs46xx/dsp_spos_scb_lib.c	Wed Jun 
| 2 14:57:41 2004
| @@ -246,6 +246,9 @@ void cs46xx_dsp_proc_register_scb_desc (
|  		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name,
|  							ins->proc_dsp_dir)) != NULL) {
|  			scb_info = kmalloc(sizeof(proc_scb_info_t), GFP_KERNEL);
| +			if (!scb_info)
| +				return;
| +                                
|  			scb_info->chip = chip;
|  			scb_info->scb_desc = scb;
|        

This seems to be missing some other cleanup on the failure path,
like it does below in the same function:

				snd_info_free_entry(entry);

--
~Randy
