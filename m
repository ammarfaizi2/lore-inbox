Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWBKKzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWBKKzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWBKKzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:55:33 -0500
Received: from mail.linicks.net ([217.204.244.146]:50868 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751314AbWBKKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:55:32 -0500
From: Nick Warne <nick@linicks.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
Date: Sat, 11 Feb 2006 10:54:50 +0000
User-Agent: KMail/1.9
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
References: <200601092022.56244.nick@linicks.net> <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
In-Reply-To: <s5hek3geyup.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111054.50947.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 18:12, Takashi Iwai wrote:

> > So bios pnp OS ON/OFF both use different alsa drivers (or parts _of_ the
> > driver) then - which in turn require different asound.state files?
>
> No, I meant -F (a capical F), which means to force to set up the
> controls even the number id mismatches.  This avoid the errors like
> above.  (The default behavior of alsactl is a bit too strict.)
>
> But, anyway, it's better to do the following:
>
> - Boot with PnP ON, run "alsactl -f state-with-pnp store"
> - Boot with PnP OFF, run "alsactl -f state-wo-pnp store"
>
> then compare these two files.

OK, sorry for a delay in reply - I haven't rebooted since last mail.

I have something _really_ peculiar ongoing on here (ignoring PnP - this isn't 
my issue now, I feel).

Info (lspci):
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)


This morning I built and installed 2.6.15.4.  On reboot, I got control errors 
again ('alsactl restore' is run from rc.local):


Sorting SB Live! sound (alsactl restore)...
alsactl: set_control:894: warning: name mismatch (Sigmatel Surround Playback 
Volume/Sigmatel Surround Playback Switch) for control #47
alsactl: set_control:896: warning: index mismatch (0/0) for control #47
alsactl: set_control:1008: bad control.47.value index


Ummm.  At the command line, same errors also.  So I deleted /etc/asound.state 
and reconfigured alsamixer from scratch.  Then following 'alsactl store', 
'alsactl restore' completes without issue (i.e. works clean).

If I then reboot, the same damn control #47 errors happen again.  It's as if 
something changes my asound.state file at boot time time?

Ideas?  This is driving me potty.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
