Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUKBVj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUKBVj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUKBVj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:39:28 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:29847 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262215AbUKBVir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:38:47 -0500
Date: Tue, 2 Nov 2004 22:38:44 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SWsuspend in 2.6.9 - sound card does not work
Message-ID: <20041102213844.GA13012@fi.muni.cz>
References: <20041027111830.GD4724@fi.muni.cz> <20041102212539.GC996@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102212539.GC996@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
: Hi!
: 
: > I have an Asus M6R laptop (http://www.fi.muni.cz/~kas/m6r/) with ATI IXP
: > integrated sound card. Under 2.6.8.1 I was able to use the sound card
: > after software suspend (just had to restore mixer settings using alsactl).
: > With 2.6.9 the sound card does not work after suspend/restore: No output no
: > matter how I change mixer settings, and the playback is not timed properly
: > (e.g. when mplayer tries to synchronize audio and video stream, the video
: > goes too fast using all CPU time and no output to speakers/phones.
: > 
: > 	I will do a binary search over 2.6.9-pre patches, but I want to ask
: > whether this problem looks familiar to anybody.
: > 
: 
: Are there any changes in the sound module?

	Yes, the difference is between 2.6.9-rc1 (works) and -rc2 (does not
work). Removing the snd-atiixp module after resume and inserting it
back again helps, but this means killing every app which uses audio
interface (so you cannot keep mplayer running over suspend/resume cycle,
and gnome-settings-daemon keeps /dev/mixer opened all the time too).

	I have tried to add printk() to
linux/sound/pci/atiixp.c:snd_atiixp_suspend() and _resume(), but I cannot
see it in dmesg(8) output after resume. Maybe those functions are not
called at all in 2.6.9-rc2 and newer.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
