Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVCGXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVCGXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVCGXhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:37:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39176 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261928AbVCGXGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:06:39 -0500
Date: Tue, 8 Mar 2005 00:06:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dtor_core@ameritech.net
Cc: Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] sound/pci/cs4281.c fix typos in the SUPPORT_JOYSTICK=n case
Message-ID: <20050307230633.GJ3170@stusta.de>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <200503070941.59365.petkov@uni-muenster.de> <20050307215206.GH3170@stusta.de> <d120d50005030714126e345fe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005030714126e345fe2@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 05:12:57PM -0500, Dmitry Torokhov wrote:
> On Mon, 7 Mar 2005 22:52:06 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > On Mon, Mar 07, 2005 at 09:41:59AM +0100, Borislav Petkov wrote:
> > >
> > > --- sound/pci/ymfpci/ymfpci.c.orig 2005-03-07 09:07:10.000000000 +0100
> > > +++ sound/pci/ymfpci/ymfpci.c 2005-03-07 09:08:02.000000000 +0100
> > > @@ -332,7 +332,9 @@ static int __devinit snd_card_ymfpci_pro
> > >    }
> > >   }
> > >
> > > +#ifdef SUPPORT_JOYSTICK
> > >   snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
> > > +#endif /* SUPPORT_JOYSTICK */
> > >
> > >   if ((err = snd_card_register(card)) < 0) {
> > >    snd_card_free(card);
> > 
> > Nice catch (but I had to apply the patch manually due to some
> > whitespace damage).
> > 
> > After a quick look, it seems there are a dozen other sound drivers (most
> > OSS but also ALSA) with similar problems.
> 
> Note that in input tree (and in -mm) I tried to clean up these #ifdefs
> by providing dummy functions when CONFIG_GAMEPORT is not selected. The
> original report caused by the typo in dummy function name
> (snc_ymfpci_create_gameport).

I was looking at -mm.

Ah OK, that sounds like a good solution.

I rechecked, and the only other non-OSS problems are in 
sound/pci/cs4281.c where the two dummy functions have the wrong names, 
too (patch below).

I'll send patches against the OSS drivers with this problem later.

> Dmitry

cu
Adrian


<--  snip  -->


This patch fixes typos in the SUPPORT_JOYSTICK=n case.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/sound/pci/cs4281.c.old	2005-03-07 23:45:01.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/pci/cs4281.c	2005-03-07 23:45:27.000000000 +0100
@@ -1331,8 +1331,8 @@
 	}
 }
 #else
-static inline int snd_cs4281_gameport(cs4281_t *chip) { return -ENOSYS; }
-static inline void snd_cs4281_gameport_free(cs4281_t *chip) { }
+static inline int snd_cs4281_create_gameport(cs4281_t *chip) { return -ENOSYS; }
+static inline void snd_cs4281_free_gameport(cs4281_t *chip) { }
 #endif /* CONFIG_GAMEPORT || (MODULE && CONFIG_GAMEPORT_MODULE) */
 
 

