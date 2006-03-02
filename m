Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWCBCYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWCBCYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWCBCYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:24:15 -0500
Received: from mail.freedom.ind.br ([201.35.65.90]:50852 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP id S932182AbWCBCYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:24:14 -0500
From: Otavio Salvador <otavio@debian.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Organization: O.S. Systems Ltda.
References: <87wtfhx7rm.fsf@nurf.casa> <s5hzmkcsv38.wl%tiwai@suse.de>
	<87slq3x3w1.fsf@nurf.casa> <s5hu0ajrbxv.wl%tiwai@suse.de>
	<87fym3w7m3.fsf@nurf.casa> <s5h3bi2a26o.wl%tiwai@suse.de>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Wed, 01 Mar 2006 23:24:02 -0300
In-Reply-To: <s5h3bi2a26o.wl%tiwai@suse.de> (Takashi Iwai's message of "Wed,
	01 Mar 2006 11:29:03 +0100")
Message-ID: <8764mxiny5.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

>> > Didn't it worked?  Which module parameter did you use?
>> 
>> I tried model=hp, model=fujistsu and priority_fix={1,2}. Neither did
>> it work.
>
> Try model=basic.  It's the old default.
> (seems that it's missing in the documentation...)

Yes. Using model=basic it works fine.

I propose the following patch to solve it then:

Do you think it's ok?

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b767552..2be4a4c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2946,8 +2946,8 @@ static int alc260_auto_init(struct hda_c
  */
 static struct hda_board_config alc260_cfg_tbl[] = {
        { .modelname = "basic", .config = ALC260_BASIC },
-       { .pci_subvendor = 0x104d, .pci_subdevice = 0x81bb,
-         .config = ALC260_BASIC }, /* Sony VAIO */
+       { .pci_subvendor = 0x104d, .pci_subdevice = 0x81bb, .config = ALC260_BASIC },
+       { .pci_subvendor = 0x8086, .pci_subdevice = 0x2668, .config = ALC260_BASIC },
        { .modelname = "hp", .config = ALC260_HP },
        { .pci_subvendor = 0x103c, .pci_subdevice = 0x3010, .config = ALC260_HP },
        { .pci_subvendor = 0x103c, .pci_subdevice = 0x3011, .config = ALC260_HP },


-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
