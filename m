Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQLSJeS>; Tue, 19 Dec 2000 04:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQLSJeL>; Tue, 19 Dec 2000 04:34:11 -0500
Received: from hermes.mixx.net ([212.84.196.2]:22287 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129874AbQLSJdx>;
	Tue, 19 Dec 2000 04:33:53 -0500
Message-ID: <3A3F245D.741EC27F@innominate.com>
Date: Tue, 19 Dec 2000 10:03:25 +0100
From: Juri Haberland <juri.haberland@innominate.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: rui.sousa@conexant.com
Cc: alan@lxorguk.ukuu.org.uk, emu10k1-devel@opensource.creative.com,
        linux-kernel@vger.kernel.org, rsousa@grad.physics.sunysb.edu
Subject: Re: emu10k1 broken in 2.2.18
In-Reply-To: <OF6B3623E3.C2E9E563-ONC12569BA.0030301F@conexant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rui.sousa@conexant.com wrote:
> 
> All reports I've seen mention that the driver works fine if compiled as a
> module. You may
> want to try that. For this reason I also don't believe the problem is the
> any of the emu10k1
> source files (which you diff'ed), unfortunately I haven't had much
> time/means to test this
> since I'm without a home PC and a SBLive.

Hi Rui,

this is unfortunately not true as I posted lately on emu10k1-devel.
If compiled as a module /dev/dsp and /dev/audio do _no_ work, but
/dev/dsp1 and /dev/audio1 do.

Someone posted a little patch that makes it work again. Here it is:

--- linux-2.2.18/drivers/sound/sound_core.c     Sun Dec 17 11:11:46 2000
+++ linux-2.2.18-emubug/drivers/sound/sound_core.c      Sun Dec 17
11:05:23 2000
@@ -436,7 +436,7 @@
 	cs4281_probe();
 #endif
 #ifdef CONFIG_SOUND_EMU10K1
-	init_emu10k1();
+/*	init_emu10k1();*/
 #endif
 #ifdef CONFIG_SOUND_YMFPCI
 	ymf_probe();


Greetings,
Juri

-- 
juri.haberland@innominate.com
system engineer                                         innominate AG
clustering & security                            the linux architects
tel: +49-30-308806-45   fax: -77            http://www.innominate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
