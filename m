Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTASAZT>; Sat, 18 Jan 2003 19:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbTASAZS>; Sat, 18 Jan 2003 19:25:18 -0500
Received: from [213.171.53.133] ([213.171.53.133]:13074 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S265246AbTASAZS>;
	Sat, 18 Jan 2003 19:25:18 -0500
Date: Sun, 19 Jan 2003 03:34:07 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Jaroslav Kysela <perex@suse.cz>
cc: Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.58][PnP] Some small points.
In-Reply-To: <Pine.LNX.4.44.0301182220430.3993-100000@pnote.perex-int.cz>
Message-ID: <Pine.BSF.4.05.10301190253300.84027-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, Jaroslav Kysela wrote:

> On Fri, 17 Jan 2003, Adam Belay wrote:
> 
> > > 4) Have we got ALSA driver that work absolutly and use PnP layer in
> > > right ways?
> > 
> > I believe Jaroslav is working on that now.  Jaroslav, if you would like me to 
> > convert ALSA drivers please let me know.
> 
> I'm working on it. Your converted drivers still misses one feature: force
> resources via module options. Two complete drivers using configuration 
> templates follow.
> 
[snip]
> -static void snd_opl3sa2_isapnp_remove(struct pnp_card * card)
> +static void __devexit snd_opl3sa2_isapnp_remove(struct pnp_card * pcard)
>  {
> -/* FIXME */
> +	snd_card_t * card = (snd_card_t *) pnpc_get_drvdata(pcard);
> +	
> +	snd_card_disconnect(card);
> +	snd_card_free_in_thread(card);
>  }
[snip]
>  static void __exit alsa_card_opl3sa2_exit(void)
>  {
> -	int idx;
> +        int dev;
>  
> -	for (idx = 0; idx < SNDRV_CARDS; idx++)
> -		snd_card_free(snd_opl3sa2_cards[idx]);
> +	pnpc_unregister_driver(&opl3sa2_pnpc_driver);
> +	for (dev = 0; dev < SNDRV_CARDS; dev++)
> +		snd_card_free(snd_opl3sa2_cards[dev]);
>  }
Hello Jaroslav and other.
I could be wrong.
1) It's cause an compilation error without CONFIG_PNP.
2) We can delete call of snd_card_free in module exit function, it'll be
freed within driver->remove call. It's realy needed only without
CONFIG_PNP_CARD.
Thanks for example of driver, I've understood some tricks from it.
	Best regards, Ruslan.

