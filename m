Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131060AbQK1VSE>; Tue, 28 Nov 2000 16:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130779AbQK1VR6>; Tue, 28 Nov 2000 16:17:58 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131060AbQK1VRn>;
        Tue, 28 Nov 2000 16:17:43 -0500
Message-ID: <20001128000456.A2732@bug.ucw.cz>
Date: Tue, 28 Nov 2000 00:04:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Thomas Sailer <sailer@ife.ee.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.4.0-testx: USB Audio
In-Reply-To: <200011271735.eARHZGZ05973@eldrich.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200011271735.eARHZGZ05973@eldrich.ee.ethz.ch>; from Thomas Sailer on Mon, Nov 27, 2000 at 06:35:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> This patch adds a workaround for the Dallas chip; the chip tags
> its 8bit formats with PCM8 but expects signed data.

> @@ -2895,6 +2897,9 @@
>  				continue;
>  			}
>  			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
> +			/* Dallas DS4201 workaround */
> +			if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
> +				format = (AFMT_S16_LE | AFMT_S8);

Should not you printk() in case of buggy hardware?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
