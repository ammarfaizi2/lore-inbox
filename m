Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290027AbSAKROx>; Fri, 11 Jan 2002 12:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290028AbSAKROn>; Fri, 11 Jan 2002 12:14:43 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:71 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290027AbSAKROd>; Fri, 11 Jan 2002 12:14:33 -0500
Date: Fri, 11 Jan 2002 12:14:31 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for ymfpci in 2.5.x
Message-ID: <20020111121431.A10147@devserv.devel.redhat.com>
In-Reply-To: <20020111004423.A22316@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020111004423.A22316@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, Jan 11, 2002 at 12:44:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am terribly sorry, but an additional fixup is needed,
as identified by Anders Rune Jensen (mental note - always
cc submissions to linux-kernel. So many good eyeballs).

--- linux-2.4.17-niph/drivers/sound/ymfpci.c.bak	Fri Jan 11 07:41:39 2002
+++ linux-2.4.17-niph/drivers/sound/ymfpci.c	Fri Jan 11 07:39:10 2002
@@ -832,7 +832,7 @@
 	u32 lpfK = ymfpci_calc_lpfK(rate);
 	ymfpci_playback_bank_t *bank;
 	int nbank;
-	unsigned le_0x40000000 = 0x40;
+	unsigned le_0x40000000 = cpu_to_le32(0x40000000);
 
 	format = (stereo ? 0x00010000 : 0) | (w_16 ? 0 : 0x80000000);
 	if (stereo)

Humbled
-- Pete

> Date: Fri, 11 Jan 2002 00:44:23 -0500
> From: Pete Zaitcev <zaitcev@redhat.com>
> To: torvalds@transmeta.com
> Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com

> While 2.5.x was a bit unstable, ymfpci in 2.4 moved ahead a bit.
> Most of it is cleanup, but there is a real fix for artsd as well.
> ALSA is supposed to supersede this code, but unless it's happening
> tomorrow we better update it before the patch grows too big.
> 
> -- Pete
> 
> diff -ur -X dontdiff linux-2.5.2-pre11/drivers/sound/ymfpci.c linux-2.5.2-pre11-p3/drivers/sound/ymfpci.c
> --- linux-2.5.2-pre11/drivers/sound/ymfpci.c	Thu Jan 10 15:52:17 2002
> +++ linux-2.5.2-pre11-p3/drivers/sound/ymfpci.c	Thu Jan 10 21:17:13 2002
>[...]
