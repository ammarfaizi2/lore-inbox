Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVLETGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVLETGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVLETGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:06:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46866 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751429AbVLETGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:06:33 -0500
Date: Mon, 5 Dec 2005 20:06:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-mm1: git-alsa-vs-git-pcmcia.patch introduces new compile errors
Message-ID: <20051205190632.GK9973@stusta.de>
References: <20051204232153.258cd554.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 11:21:53PM -0800, Andrew Morton wrote:
>...
>  Subsystem trees
>...
> +git-alsa-vs-git-pcmcia.patch
> 
>  Try to fix clash between two subsystem trees
>...

git-alsa.patch completely removes pdacf_t, and this patch adds a user 
resulting in the following compile error:

<--  snip  -->

...
  CC      sound/pcmcia/pdaudiocf/pdaudiocf.o
sound/pcmcia/pdaudiocf/pdaudiocf.c: In function 'pdacf_suspend':
sound/pcmcia/pdaudiocf/pdaudiocf.c:301: warning: passing argument 1 of 'snd_pdacf_suspend' from incompatible pointer type
sound/pcmcia/pdaudiocf/pdaudiocf.c: In function 'pdacf_resume':
sound/pcmcia/pdaudiocf/pdaudiocf.c:314: error: 'pdacf_t' undeclared (first use in this function)
sound/pcmcia/pdaudiocf/pdaudiocf.c:314: error: (Each undeclared identifier is reported only once
sound/pcmcia/pdaudiocf/pdaudiocf.c:314: error: for each function it appears in.)
sound/pcmcia/pdaudiocf/pdaudiocf.c:314: error: 'chip' undeclared (first use in this function)
make[3]: *** [sound/pcmcia/pdaudiocf/pdaudiocf.o] Error 1

<--  snip  -->

git-alsa.patch removes some more code git-alsa-vs-git-pcmcia.patch adds 
users for:

<--  snip  -->

...
  CC      sound/pcmcia/vx/vxpocket.o
sound/pcmcia/vx/vxpocket.c: In function 'vxp_suspend':
sound/pcmcia/vx/vxpocket.c:296: error: 'struct snd_card' has no member named 'pm_suspend'
sound/pcmcia/vx/vxpocket.c:298: error: 'struct snd_card' has no member named 'pm_suspend'
sound/pcmcia/vx/vxpocket.c: In function 'vxp_resume':
sound/pcmcia/vx/vxpocket.c:310: error: 'vx_core_t' undeclared (first use in this function)
sound/pcmcia/vx/vxpocket.c:310: error: (Each undeclared identifier is reported only once
sound/pcmcia/vx/vxpocket.c:310: error: for each function it appears in.)
sound/pcmcia/vx/vxpocket.c:310: error: 'chip' undeclared (first use in this function)
make[3]: *** [sound/pcmcia/vx/vxpocket.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

