Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVEQMCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVEQMCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 08:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVEQMCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 08:02:50 -0400
Received: from smtp06.auna.com ([62.81.186.16]:13294 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261413AbVEQMCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 08:02:46 -0400
Date: Tue, 17 May 2005 12:02:39 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	<1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
In-Reply-To: <s5hvf5nsb2r.wl@alsa2.suse.de> (from tiwai@suse.de on Fri May
	13 11:57:00 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1116331359l.7364l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Tue, 17 May 2005 14:02:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.13, Takashi Iwai wrote:
> At Thu, 12 May 2005 22:27:16 +0000,
> J.A. Magallon wrote:
> > 
> > Just a note: I need also to uncheck the 'Center/LFE jack as mic'
> > switch.
> 
> Oh, it shouldn't be there :)
> Try the patch below.  I'll commit it to ALSA tree.
> 
> 
> > And a question. The output level depends on the
> > Line _input_ volume. Higher the volume, lower the output level on
> > all channels.
> > This happens only if I 'Spread Front to Sourround and Center/LFE'.
> > Should not the line volume be useless if the jack is set for output ?
> > Or does its meaning change then...
> 
> Hmm, it's weird.  I don't see the signal routing via line-in control
> to outputs in AD1985 datasheet...
> 
> 
> Takashi
> 
> 
> --- linux/sound/pci/ac97/ac97_patch.c	11 May 2005 11:00:17 -0000	1.82
> +++ linux/sound/pci/ac97/ac97_patch.c	13 May 2005 09:35:19 -0000
> @@ -1598,7 +1598,6 @@
>  }
>  
>  static const snd_kcontrol_new_t snd_ac97_ad1985_controls[] = {
> -	AC97_SINGLE("Center/LFE Jack as Mic", AC97_AD_SERIAL_CFG, 9, 1, 0),
>  	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0)
>  };
>  

If I apply this, the control disappears, but I can't get any sound in that
ouput even if I put ALSA in 6ch mode. It seems it defaults to 'on', and
the mode switch '2ch -> 4ch -> 6ch' does not touch it. So it does not look
like a redundant control.

Example: go into 4ch mode. Check this control. Then switch to 6ch mode.
The Center jack has no sound (it should, shouldn't ?). Check it and voilà.
It looks that the logic in the channel selection needs to set this flag also...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam19 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


