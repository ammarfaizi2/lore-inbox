Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbUKLLfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUKLLfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 06:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUKLLfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 06:35:19 -0500
Received: from witte.sonytel.be ([80.88.33.193]:25553 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262508AbUKLLew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 06:34:52 -0500
Date: Fri, 12 Nov 2004 12:34:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Randy Dunlap <rddunlap@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more MODULE_PARM conversions
In-Reply-To: <200411112325.iABNPsWo013185@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0411121232570.27077@waterleaf.sonytel.be>
References: <200411112325.iABNPsWo013185@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.2156, 2004/11/11 13:50:06-08:00, rddunlap@osdl.org
> 
> 	[PATCH] more MODULE_PARM conversions
> 	
> 	Convert MODULE_PARM() to module_param().
> 	
> 	Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

> diff -Nru a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
> --- a/drivers/scsi/mesh.c	2004-11-11 15:26:05 -08:00
> +++ b/drivers/scsi/mesh.c	2004-11-11 15:26:05 -08:00
> @@ -60,22 +60,22 @@
>  MODULE_DESCRIPTION("PowerMac MESH SCSI driver");
>  MODULE_LICENSE("GPL");
>  
> -MODULE_PARM(sync_rate, "i");
> -MODULE_PARM_DESC(sync_rate, "Synchronous rate (0..10, 0=async)");
> -MODULE_PARM(sync_targets, "i");
> -MODULE_PARM_DESC(sync_targets, "Bitmask of targets allowed to set synchronous");
> -MODULE_PARM(resel_targets, "i");
> -MODULE_PARM_DESC(resel_targets, "Bitmask of targets allowed to set disconnect");
> -MODULE_PARM(debug_targets, "i");
> -MODULE_PARM_DESC(debug_targets, "Bitmask of debugged targets");
> -MODULE_PARM(init_reset_delay, "i");
> -MODULE_PARM_DESC(init_reset_delay, "Initial bus reset delay (0=no reset)");
> -
>  static int sync_rate = CONFIG_SCSI_MESH_SYNC_RATE;
>  static int sync_targets = 0xff;
>  static int resel_targets = 0xff;
>  static int debug_targets = 0;	/* print debug for these targets */
>  static int init_reset_delay = CONFIG_SCSI_MESH_RESET_DELAY_MS;
> +
> +MODULE_PARM(sync_rate, int, 0);
   ^^^^^^^^^^^
Shouldn't these be module_parm?

> +MODULE_PARM_DESC(sync_rate, "Synchronous rate (0..10, 0=async)");
> +MODULE_PARM(sync_targets, int, 0);
> +MODULE_PARM_DESC(sync_targets, "Bitmask of targets allowed to set synchronous");
> +MODULE_PARM(resel_targets, int, 0);
> +MODULE_PARM_DESC(resel_targets, "Bitmask of targets allowed to set disconnect");
> +MODULE_PARM(debug_targets, int, 0644);
> +MODULE_PARM_DESC(debug_targets, "Bitmask of debugged targets");
> +MODULE_PARM(init_reset_delay, int, 0);
> +MODULE_PARM_DESC(init_reset_delay, "Initial bus reset delay (0=no reset)");
>  
>  static int mesh_sync_period = 100;
>  static int mesh_sync_offset = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
