Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVJCGXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVJCGXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVJCGXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:23:52 -0400
Received: from paegas2.mail-atlas.net ([212.47.13.187]:7443 "EHLO
	paegas2.mail-atlas.net") by vger.kernel.org with ESMTP
	id S932159AbVJCGXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:23:51 -0400
From: "Peter Zubaj" <pzad@pobox.sk>
To: "Dave Jones" <davej@redhat.com>
CC: alsa-devel@alsa-project.org, James@superbug.co.uk,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       perex@suse.cz
Message-ID: <7a5967f2d895440aa1ca2fa1d201c380@pobox.sk>
Date: Mon, 03 Oct 2005 08:23:28 +0200
X-Priority: 3 (Normal)
Subject: Re: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK this was fixed in CVS. Two cards have same model id (one has AC97, one not).

Fix:

http://sourceforge.net/mailarchive/forum.php?thread_id=8360485&forum_id=33141

Peter Zubaj

>-----P?vodn? spr?va-----
>Od: Dave Jones [mailto:davej@redhat.com]
>Odoslan?: 3. okt?bra 2005 1:28
>Komu: Linux Kernel Mailing List
>K?pia: alsa-devel@alsa-project.org; James@superbug.co.uk; perex@suse.cz
>Predmet: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
>
>
>On Tue, Sep 13, 2005 at 12:07:43PM -0700, Linux Kernel wrote:
>> tree b885c7a937061624c7f7e34444122b96cced5c16
>> parent 1b44c28dc180f4d0ea109e1fe4339b3403c2d530
>> author James Courtier-Dutton <James@superbug.co.uk> Sat, 10 Sep 2005 10:24:10 +0200
>> committer Jaroslav Kysela <perex@suse.cz> Mon, 12 Sep 2005 10:48:32 +0200
>>
>> [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
>>
>> EMU10K1/EMU10K2 driver
>> The card does not have an AC97 chip.
>> .subsystem = 0x80611102
>>
>> Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
>>
>>  sound/pci/emu10k1/emu10k1_main.c |    5 ++---
>>  1 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
>> --- a/sound/pci/emu10k1/emu10k1_main.c
>> +++ b/sound/pci/emu10k1/emu10k1_main.c
>> @@ -754,12 +754,11 @@ static emu_chip_details_t emu_chip_detai
>>  	 .emu10k1_chip = 1,
>>  	 .ac97_chip = 1,
>>  	 .sblive51 = 1} ,
>> -	/* Tested by alsa bugtrack user "hus" 12th Sept 2005 */
>> +	/* Tested by alsa bugtrack user "hus" bug #1297 12th Aug 2005 */
>>  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
>> -	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]",
>> +	 .driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]",
>>  	 .id = "Live",
>>  	 .emu10k1_chip = 1,
>> -	 .ac97_chip = 1,
>>  	 .sblive51 = 1} ,
>>  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
>>  	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]",
>
>That last line change reverts..
>
>tree efc4e418c80bf61beb2e1cfd1b2db405b471111f
>parent 9970dce56686d7b71310388025d8925d3d29e6ec
>author Takashi Iwai <tiwai@suse.de> Fri, 26 Aug 2005 17:26:40 +0200
>committer Jaroslav Kysela <perex@suse.cz> Tue, 30 Aug 2005 08:47:46 +0200
>
>[ALSA] emu10k1 - Add missing ac97 support on SBLive! Player 5.1
>
>EMU10K1/EMU10K2 driver
>Added the missing ac97 support on SBLive! Player 5.1.
>
>And makes peoples volume sliders disappear, which tends to upset folks.
>See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169152
>for reference.
>
>Signed-off-by: Dave Jones <davej@redhat.com>
>
>--- linux-2.6.13/sound/pci/emu10k1/emu10k1_main.c~	2005-10-02 21:26:40.000000000 -0400
>+++ linux-2.6.13/sound/pci/emu10k1/emu10k1_main.c	2005-10-02 21:26:57.000000000 -0400
>@@ -759,6 +759,7 @@ static emu_chip_details_t emu_chip_detai
>.driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]",
>.id = "Live",
>.emu10k1_chip = 1,
>+	 .ac97_chip = 1,
>.sblive51 = 1} ,
>{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
>.driver = "EMU10K1", .name = "SBLive! Value [CT4850]",
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


