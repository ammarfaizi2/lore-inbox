Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266620AbRGPJW4>; Mon, 16 Jul 2001 05:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbRGPJWq>; Mon, 16 Jul 2001 05:22:46 -0400
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:20580 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266620AbRGPJWk>; Mon, 16 Jul 2001 05:22:40 -0400
Message-ID: <3B52B25A.5050102@humboldt.co.uk>
Date: Mon, 16 Jul 2001 10:22:34 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010531
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.6-ac2: "uart401: bad devc"
In-Reply-To: <20010715195903.A5982@gondor.com>
Content-Type: multipart/mixed;
 boundary="------------060209060607060904080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209060607060904080903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jan Niehusmann wrote:

> Linux 2.4.6-ac2 with CONFIG_MIDI_VIA82CXXX set does cause a 
> kernel hang on my setup. On the first sound I play (ie cat >/dev/dsp)
> an endless stream of "uart401: bad devc" messages shows up on the 
> console - everything else hangs.


The attached patch should fix the problem.

-- 
Adrian Cox   http://www.humboldt.co.uk/

--------------060209060607060904080903
Content-Type: text/plain;
 name="viamidi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="viamidi.patch"

===== drivers/sound/via82cxxx_audio.c 1.12 vs edited =====
--- 1.12/drivers/sound/via82cxxx_audio.c	Thu Jun 28 16:34:45 2001
+++ edited/drivers/sound/via82cxxx_audio.c	Mon Jul 16 10:19:52 2001
@@ -1641,7 +1641,8 @@
 	if (!(status32 & VIA_INTR_MASK))
         {
 #ifdef CONFIG_MIDI_VIA82CXXX
-                uart401intr(irq, card->midi_devc, regs);
+	    	 if (card->midi_devc)
+                    	uart401intr(irq, card->midi_devc, regs);
 #endif
 		return;
     	}	    

--------------060209060607060904080903--

