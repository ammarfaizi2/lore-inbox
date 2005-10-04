Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVJDGkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJDGkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVJDGkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:40:16 -0400
Received: from paegas.mail-atlas.net ([212.47.13.186]:56071 "EHLO
	paegas.mail-atlas.net") by vger.kernel.org with ESMTP
	id S932389AbVJDGkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:40:14 -0400
From: "Peter Zubaj" <pzad@pobox.sk>
To: "Dave Jones" <davej@redhat.com>
CC: alsa-devel@alsa-project.org, James@superbug.co.uk,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       perex@suse.cz
Message-ID: <dc7e3d7c111741a991e11a1a39ca9262@pobox.sk>
Date: Tue, 04 Oct 2005 08:39:36 +0200
X-Priority: 3 (Normal)
Subject: Re: Re: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If ac97_chip=1 and ac97 doesn't exists - driver will refuse to load.
If ac97_chip=2 and ac97 doesn't exists - driver should ignore ac97

But I don't know if this is correct (I am not author of patch and I not tested it).
if message is printed then there is
goto no_ac97; /* FIXME: get rid of ugly gotos.. */
this will skip ac97 mixer creation (if ac97 is not there this will fail and driver refuses to load)
But I don't know if snd_ac97_bus will fail if there is no ac97 codec (I think - not, and this is not correct), then test should be done on snd_ac97_mixer and not on snd_ac97_bus creation.

Peter Zubaj

>-----P?vodn? spr?va-----
>Od: Dave Jones [mailto:davej@redhat.com]
>Odoslan?: 4. okt?bra 2005 0:54
>Komu: Peter Zubaj
>K?pia: alsa-devel@alsa-project.org; James@superbug.co.uk; Linux Kernel Mailing List; perex@suse.cz
>Predmet: Re: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
>
>
>On Mon, Oct 03, 2005 at 08:23:28AM +0200, Peter Zubaj wrote:
>> AFAIK this was fixed in CVS. Two cards have same model id (one has AC97, one not).
>>
>> Fix:
>>
>> http://sourceforge.net/mailarchive/forum.php?thread_id=8360485&forum_id=33141
>>
>
>From the look of that patch, this will just print
>"emu10k1: AC97 is optional on this board Proceeding without ac97 mixers..."
>and do nothing about actually making things work for people again,
>or even to suggest what they can do to work around this situation
>when their volume control breaks.  At the least this sounds like it
>needs to mention a module parameter to force ac97 support.
>
>What actually happens if we set ac97_chip=1 on the boards that
>don't have it ? Is it purely a cosmetic thing, showing some
>sliders that do nothing?
>
>Dave
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussions,
>and more. http://solutions.newsforge.com/ibmarch.tmpl
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel



Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!


