Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTAUKoA>; Tue, 21 Jan 2003 05:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTAUKoA>; Tue, 21 Jan 2003 05:44:00 -0500
Received: from gate.perex.cz ([194.212.165.105]:25104 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266965AbTAUKn6>;
	Tue, 21 Jan 2003 05:43:58 -0500
Date: Tue, 21 Jan 2003 11:52:38 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: "Ruslan U. Zakirov" <cubic@miee.ru>
Cc: Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.58][PnP] Some small points.
In-Reply-To: <Pine.BSF.4.05.10301190253300.84027-100000@wildrose.miee.ru>
Message-ID: <Pine.LNX.4.44.0301211151320.2009-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003, Ruslan U. Zakirov wrote:

> On Sat, 18 Jan 2003, Jaroslav Kysela wrote:
> 
> > On Fri, 17 Jan 2003, Adam Belay wrote:
> > 
> > > > 4) Have we got ALSA driver that work absolutly and use PnP layer in
> > > > right ways?
> > > 
> > > I believe Jaroslav is working on that now.  Jaroslav, if you would like me to 
> > > convert ALSA drivers please let me know.
> > 
> > I'm working on it. Your converted drivers still misses one feature: force
> > resources via module options. Two complete drivers using configuration 
> > templates follow.
> > 
> [snip]
> > -static void snd_opl3sa2_isapnp_remove(struct pnp_card * card)
> > +static void __devexit snd_opl3sa2_isapnp_remove(struct pnp_card * pcard)
> >  {
> > -/* FIXME */
> > +	snd_card_t * card = (snd_card_t *) pnpc_get_drvdata(pcard);
> > +	
> > +	snd_card_disconnect(card);
> > +	snd_card_free_in_thread(card);
> >  }
> [snip]
> >  static void __exit alsa_card_opl3sa2_exit(void)
> >  {
> > -	int idx;
> > +        int dev;
> >  
> > -	for (idx = 0; idx < SNDRV_CARDS; idx++)
> > -		snd_card_free(snd_opl3sa2_cards[idx]);
> > +	pnpc_unregister_driver(&opl3sa2_pnpc_driver);
> > +	for (dev = 0; dev < SNDRV_CARDS; dev++)
> > +		snd_card_free(snd_opl3sa2_cards[dev]);
> >  }
> Hello Jaroslav and other.
> I could be wrong.
> 1) It's cause an compilation error without CONFIG_PNP.

Yes, the opl3sa2_pnpc_driver structure is not defined. Corrected.

> 2) We can delete call of snd_card_free in module exit function, it'll be
> freed within driver->remove call. It's realy needed only without
> CONFIG_PNP_CARD.

No, we can mix pnp and non-pnp cards. The non-pnp cards have to be 
removed manually.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

