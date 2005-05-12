Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVELW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVELW1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVELW1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:27:55 -0400
Received: from smtp04.auna.com ([62.81.186.14]:1502 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262158AbVELW1T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:27:19 -0400
Date: Thu, 12 May 2005 22:27:16 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
In-Reply-To: <s5hd5rx2656.wl@alsa2.suse.de> (from tiwai@suse.de on Wed May
	11 16:23:33 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1115936836l.8448l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Fri, 13 May 2005 00:27:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.11, Takashi Iwai wrote:
> At Sun, 08 May 2005 23:24:40 +0000,
> J.A. Magallon wrote:
> > 
> > 
> > On 05.08, J.A. Magallon wrote:
> > > 
> > > On 05.05, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> > > > 
> > > > - device mapper updates
> > > > 
> > > > - more UML updates
> > > > 
> > > > - -mm seems unusually stable at present.
> > > > 
> > > 
> > > Ehem, is ALSA broken ?
> > > 
> > > I can't spread stereo output to 4 channel. More specific, I can't switch
> > > one of my female jacks between in and out.
> > > 
> > > Long explanation: I have an
> > > 
> > > 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> > > 
> > > It has three outputs. One is always output, for normal stereo or front in 4
> > > channel. One other is LineIn/Back-for-4-channel. And the third is
> > > Mic/Bass-Center.
> > > 
> > > In 2.6.11 I have two
> > > toggles in ALSA: 'Spread front to center...' and 'surround jack as input'
> > > Adjusting both I could get to duplicate the output in the Back jack.
> > > In 2.6.12-rc3-mm3 there is no way to get this working.
> > > 
> > 
> > I have just tested in 2.6.12-rc4 and works fine. I even feed the stereo
> > signal to the 6 channels, so 4 go to my desktop speaker system and one
> > other pair to may home stereo.
> > 
> > Something is broken in -mm wrt ALSA. If you need me to test some specific
> > version, pleas just ask.
> > 
> > Side note: trying to load settings from rc4 in -mm says:
> > 
> > alsactl: set_control:930: warning: name mismatch (Surround Jack as Input/Surround Jack Mode) for control #42
> > alsactl: set_control:932: warning: index mismatch (0/0) for control #42
> > alsactl: set_control:1030: bad control.42.value type
> 
> The mixer controls for the surround jacks are changed in the recent
> version.  Instead of "Line-In As Surround" or "Surround Jack As
> Input" switches, now there are two enum controls:
> 
> - "Channel Mode"  (2ch/4ch/6ch)
>    controls the surround output channels, i.e. toggles the I/O
>    direction of the shared line-in/mic jacks.
> 
> - "Surround Jack Mode" (Shared/Independent)
>    controls the line and mic jacks are shared for surround output and
>    inputs.  "Independent" is for the recent mobos which have separate
>    input and output jacks.  When Independent is chosen, the setting in
>    "Channel Mode" has no influence.
> 
> 
> In your case, set "Channel Mode" to 4ch and "Surround Jack Mode" to 
> Shared so that the line-in jack is used as surround output.
> Then turn on "Duplicate Front" switch.
> 
> I'll prepare a better documentation later...

Thanks, now I got it working. Stereo spread to all 6 channels.
Just a note: I need also to uncheck the 'Center/LFE jack as mic'
switch.

And a question. The output level depends on the
Line _input_ volume. Higher the volume, lower the output level on
all channels.
This happens only if I 'Spread Front to Sourround and Center/LFE'.
Should not the line volume be useless if the jack is set for output ?
Or does its meaning change then...

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam17 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


