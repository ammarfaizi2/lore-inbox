Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUDCPWo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDCPWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 10:22:44 -0500
Received: from gprs214-163.eurotel.cz ([160.218.214.163]:20864 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261785AbUDCPWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 10:22:42 -0500
Date: Sat, 3 Apr 2004 17:22:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: Rajsekar <rajsekar@peacock.iitm.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: alsamixer muting when restoring from suspend.
Message-ID: <20040403152227.GA212@elf.ucw.cz>
References: <y49y8phn2op.fsf@sahana.cs.iitm.ernet.in> <s5hk710vy8x.wl@alsa2.suse.de> <20040402205723.GJ195@elf.ucw.cz> <s5h8yhdxo58.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8yhdxo58.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This I think is not a problem but rather a subtle bug.
> > > > 
> > > > Alsamixer by default mutes all channels when loaded.
> > > > So when I `swsusp' my comp while I listen to music and restore the music
> > > > plays from where it left alright, but the channels are muted.
> > > > Is there a way to unmute them implicitly when restoring.
> > > 
> > > which driver?
> > > not all drivers have suspend/resume callbacks.
> > 
> > Could it be solved at higher layer, perhaps? Setting volume is common
> > to all drivers, and some kind of generic_alsa_suspend every alsa
> > driver would call might help...
> 
> the problem is also that you need to reinitialize the chip after
> resume.  the restoration of mixer config could be done by calling
> "alsactl store" at the suspend and "alsactl restore" at the resume in
> the user space.  can apmd work for such a purpose even for software
> suspend?

Userspace should not be involved in suspend/resume. Having in-kernel
equivalent of alsactl store / alsactl restore might help alsa driver
authors... And might be enough for suspend-to-disk to +/- work. (Well,
unless sound was playing when user requested suspend, that one needs
proper support).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
