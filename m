Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSGOLD3>; Mon, 15 Jul 2002 07:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSGOLD2>; Mon, 15 Jul 2002 07:03:28 -0400
Received: from t2o53p72.telia.com ([62.20.228.192]:54656 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S317430AbSGOLD2>;
	Mon, 15 Jul 2002 07:03:28 -0400
To: "D. Sen" <dsen@homemail.com>
Cc: linux-kernel@vger.kernel.org,
       Andreas Bombe <bombe@informatik.tu-muenchen.de>
Subject: Re: "PCI: Cannot allocate resource region" messages at boot
References: <3D2EF7F2.1070107@homemail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jul 2002 13:04:59 +0200
In-Reply-To: <3D2EF7F2.1070107@homemail.com>
Message-ID: <m28z4dfe04.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Sen" <dsen@homemail.com> writes:

> I am getting these messages during bootup time on an IBM Thinkpad T30:
> 
> Jul 11 17:17:24 calliope kernel: PCI: Cannot allocate resource region
> 0 of device 02:00.0
> Jul 11 17:17:24 calliope kernel: PCI: Cannot allocate resource region
> 0 of device 02:00.1

I had a similar problem on my notebook, but this patch seems to fix
it:

--- linux/drivers/pcmcia/yenta.c.orig	Mon Jul 15 12:40:54 2002
+++ linux/drivers/pcmcia/yenta.c	Mon Jul 15 12:40:39 2002
@@ -736,7 +736,7 @@
 		return;
 	}
 
-	align = size = 4*1024*1024;
+	align = size = 128*1024;
 	min = PCIBIOS_MIN_MEM; max = ~0U;
 	if (type & IORESOURCE_IO) {
 		align = 1024;

I have no idea if this is the right thing to do. I found the
suggestion in an earlier message from Andreas Bombe.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
