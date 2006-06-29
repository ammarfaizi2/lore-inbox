Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWF2KDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWF2KDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWF2KDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:03:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30378 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751332AbWF2KDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:03:32 -0400
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver II
Date: Thu, 29 Jun 2006 12:03:22 +0200
User-Agent: KMail/1.9.3
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <200606252139.36002.ak@suse.de> <200606262028.31807.ak@suse.de> <s5hmzbz92i6.wl%tiwai@suse.de>
In-Reply-To: <s5hmzbz92i6.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291203.22773.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 20:48, Takashi Iwai wrote:
> At Mon, 26 Jun 2006 20:28:31 +0200,
> Andi Kleen wrote:
> > 
> > 
> > > OK, and still you get the same error like:
> > > 
> > > 	ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> > > 	...
> > > ??
> > 
> > Yes.
> > 
> > > Any change if you set CONFIG_SND_DYNAMIC_MINORS=y ?
> > 
> > With that it finally works. Thanks.
> > 
> > Still can it be fixed?
> 
> Well, the bug shall be fixed :)
> 
> Unfortunately I cannot reproduce this on my systems that are all based
> on SUSE 10.1, and the latest 2.6.17-git works fine even
> CONFIG_SND_DYNAMIC_MINORS=n as far as I've tested.
> 
> Could you check the strace and what open error occurs?
> I suppose it's /dev/snd/controlC0, but don't figure out exactly.

Sorry for the delay

(as root) I get

5184  open("/dev/snd/controlC0", O_RDONLY) = -1 EACCES (Permission denied)
5184  open("/dev/snd/controlC1", O_RDONLY) = -1 EACCES (Permission denied)
... (upto 31) ...
5184  open("/dev/sound/dsp", O_WRONLY|O_NONBLOCK) = -1 ENOENT (No such file or d
5184  open("/dev/dsp", O_WRONLY|O_NONBLOCK) = -1 EACCES (Permission denied)

ccontrol0 is
crw-------  1 andi audio 116, 6 2006-06-29 11:49 /dev/snd/controlC0

It also doesn't work as andi

I stuck printks to the EACCES in sound/* and they don't trigger so it must
be somewhere else.


-Andi
