Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVCGW6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVCGW6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCGW4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:56:00 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:22078 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261861AbVCGWM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:12:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XG1Qb619KH2pnDFWSj3rLdu/2PT5k9pk0H5xEPARPDhYoh9cAFYAfa5/RCuuvHnscVi3XNgBM5/93V7XfKOeP6NuER3LkF2/0+TZZpQj/obWWLkw1w+rLStP6EC5uvH9BlfUY7gDTe+km4eDS8WH49T4QFOAOU6eGH9sLcScti0=
Message-ID: <d120d50005030714126e345fe2@mail.gmail.com>
Date: Mon, 7 Mar 2005 17:12:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.11-mm1: sound <-> GAMEPORT problems
Cc: Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050307215206.GH3170@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	 <200503070941.59365.petkov@uni-muenster.de>
	 <20050307215206.GH3170@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005 22:52:06 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Mar 07, 2005 at 09:41:59AM +0100, Borislav Petkov wrote:
> > On Friday 04 March 2005 12:32, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> > >-mm1/
> > >
> > <snip>
> >
> > Hi,
> >
> > the ymfpci sound driver wouldn't compile without gameport support selected
> > since the sound card has a gameport on it:
> >
> > Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> >
> > --- sound/pci/ymfpci/ymfpci.c.orig 2005-03-07 09:07:10.000000000 +0100
> > +++ sound/pci/ymfpci/ymfpci.c 2005-03-07 09:08:02.000000000 +0100
> > @@ -332,7 +332,9 @@ static int __devinit snd_card_ymfpci_pro
> >    }
> >   }
> >
> > +#ifdef SUPPORT_JOYSTICK
> >   snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
> > +#endif /* SUPPORT_JOYSTICK */
> >
> >   if ((err = snd_card_register(card)) < 0) {
> >    snd_card_free(card);
> 
> Nice catch (but I had to apply the patch manually due to some
> whitespace damage).
> 
> After a quick look, it seems there are a dozen other sound drivers (most
> OSS but also ALSA) with similar problems.

Note that in input tree (and in -mm) I tried to clean up these #ifdefs
by providing dummy functions when CONFIG_GAMEPORT is not selected. The
original report caused by the typo in dummy function name
(snc_ymfpci_create_gameport).

-- 
Dmitry
