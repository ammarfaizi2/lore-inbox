Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130146AbQLHTBz>; Fri, 8 Dec 2000 14:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbQLHTBr>; Fri, 8 Dec 2000 14:01:47 -0500
Received: from ns1.metabyte.com ([216.218.208.34]:15107 "EHLO ns1.metabyte.com")
	by vger.kernel.org with ESMTP id <S130146AbQLHTBk>;
	Fri, 8 Dec 2000 14:01:40 -0500
From: Pete Zaitcev <zaitcev@metabyte.com>
Message-Id: <200012081831.KAA06813@ns1.metabyte.com>
Subject: Re: [PATCH] for YMF PCI sound cards
To: proski@gnu.org (Pavel Roskin)
Date: Fri, 8 Dec 2000 10:31:10 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        zaitcev@metabyte.com (Pete Zaitcev), perex@suse.cz (Jaroslav Kysela)
In-Reply-To: <Pine.LNX.4.30.0012081128330.5353-100000@fonzie.nine.com> from "Pavel Roskin" at Dec 08, 2000 11:41:07 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 8 Dec 2000 11:41:07 -0500 (EST)
> From: Pavel Roskin <proski@gnu.org>
> To: <linux-kernel@vger.kernel.org>
> cc: <linux-sound@vger.kernel.org>, Pete Zaitcev <zaitcev@metabyte.com>,
>         Jaroslav Kysela <perex@suse.cz>

> --- ./drivers/sound/Config.in	Thu Dec  7 10:59:06 2000
> +++ ./drivers/sound/Config.in	Fri Dec  8 11:25:08 2000

No problem here.

> --- ./drivers/sound/ymfpci.c	Thu Dec  7 10:59:06 2000
> +++ ./drivers/sound/ymfpci.c	Fri Dec  8 11:33:51 2000

The idea of the patch looks good but there is a small problem.
I have an open/close fix queued with Alan for post-2.2.18,
which changes the enumeration scheme for ymfcpi to make it
more friendly to other sound cards (Bug from Abhijit Menon-Sen).
This is a conflict because you use instance number to find
what card goes in first. In fact I plan to send the same
thing to Linus for 2.4 (if he have not fixed that already).

Would you please to hold on to your patch for couple of weeks
and then resync and redo it? Alternatively, I'll keep your
patch and will reapply it in the way I see sane, but you will
have to retest it before I issue it.

> --- ./drivers/sound/ac97_codec.c	Thu Dec  7 10:59:06 2000
> +++ ./drivers/sound/ac97_codec.c	Thu Dec  7 11:00:44 2000
> @@ -61,6 +61,7 @@
>  } ac97_codec_ids[] = {
>  	{0x414B4D00, "Asahi Kasei AK4540 rev 0", NULL},
>  	{0x414B4D01, "Asahi Kasei AK4540 rev 1", NULL},
> +	{0x41445303, "Yamaha YMF????"          , NULL},

Are you sure it's correct? I am almost certain that no YMFxxx
has on-chip AC97. I'd like to see a document that allows you
the change quoted above.

--Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
