Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWBTTTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWBTTTN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWBTTTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:19:12 -0500
Received: from mail.linicks.net ([217.204.244.146]:16274 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932643AbWBTTTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:19:12 -0500
From: Nick Warne <nick@linicks.net>
To: Lee Revell <rlrevell@joe-job.com>, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Date: Mon, 20 Feb 2006 19:18:56 +0000
User-Agent: KMail/1.9.1
References: <20060218231419.GA3219@elf.ucw.cz> <200602192020.36343.nick@linicks.net> <1140381117.2733.374.camel@mindpipe>
In-Reply-To: <1140381117.2733.374.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201918.57087.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 20:31, you wrote:
> On Sun, 2006-02-19 at 20:20 +0000, Nick Warne wrote:
> > On Sunday 19 February 2006 19:29, Lee Revell wrote:
> > > > And now the confusing bit.  If I run alsamixer but DO NOT DO
> > > > ANYTHING, exit, then issue 'alsactl store', then 'alsactl restore'
> > > > works again OK - until next reboot...
> > >
> > > Sounds like you have 2 different alsactls installed.  The ALSA default
> > > one saves the mixer state in /etc/asound.state but lots of distros hack
> > > it up to save the state somewhere under /var.
> > >
> > > Use "alsactl -f" to force a restore of mixer state even if the mixer
> > > controls have changed (distros should do this by default but don't).
> >
> > Lee,
> >
> > Everybody here keeps saying that to me - I _don't_ have two alsactl's, I
> > _don't_ have 2 asound.states (or more/any other alsactl files).
> >
> > My base is Slackware 10 - a pretty clean distro.
> >
> > Tonight my MIC is not working again from a reboot, and I can't get it
> > going like I did before (??)...
> >
> > Every reboot 'alsactl restore' breaks on one control or another now.
> >
> > You mean -F too?  I don't understand why I should have to use --force.
> >
> > It's a mystery?
>
> Sorry, no idea.  You'll have to do a binary search with ALSA CVS to find
> out exactly when it broke.

I have a mystery here guys.

Tonight I tested.  I set up my system so that both sudo and root could 
`alsactl store/restore' using -f to explicitly use /etc/asound.state.

Once both user and root could store/restore with no errors, and all my apps 
work (midi, mic, KDE sound etc. etc.) I made /etc/asound.state immutable:

nick@linuxamd:nick$ lsattr /etc/asound.state
----i-------- /etc/asound.state

I then edited /etc/rc.d/rc/alsa to use the -f and expilicity point 
to /etc/asound.state

Rebooted...

Loading ALSA mixer settings:  /usr/sbin/alsactl restore
/usr/sbin/alsactl: set_control:894: warning: name mismatch (Mic Select/3D 
Control Sigmatel - Depth) for control #74
/usr/sbin/alsactl: set_control:896: warning: index mismatch (0/0) for control 
#74
/usr/sbin/alsactl: set_control:994: bad control.74.value type

Heh.  Every reboot I get a different control error.  But why it all works OK 
before a reboot with the same very /etc/asound.state file I don't know.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
