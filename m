Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131358AbRA0K4K>; Sat, 27 Jan 2001 05:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbRA0K4A>; Sat, 27 Jan 2001 05:56:00 -0500
Received: from [194.213.32.137] ([194.213.32.137]:35076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131358AbRA0Kzv>;
	Sat, 27 Jan 2001 05:55:51 -0500
Message-ID: <20010127112629.B163@bug.ucw.cz>
Date: Sat, 27 Jan 2001 11:26:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Rankin <rankinc@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH](s): Use spinlocks instead of STI/CLI in SoundBlaster
In-Reply-To: <200101260642.f0Q6gR419611@wellhouse.underworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200101260642.f0Q6gR419611@wellhouse.underworld>; from Chris Rankin on Fri, Jan 26, 2001 at 05:42:27PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I hear on the grapevine that 2.4 kernel modules should use spinlocks
> in preference to cli() and sti(). Well I'm not sure how big a win it
> is, particularly on a UP machine, but here's a patch for the
> SoundBlaster. I've added a spinlock_t to the "struct b_devc" so that
> multiple SoundBlasters each get their own lock. After all, each SB has
> its own IRQ and IO, correct?
> 
> There also seems to be something here called a Jazz16. This has a
> global lock because it looks like there can only be one of them.

Should not you initialize spinlock?

> --- linux-2.4.0/drivers/sound/sb.h.orig	Fri Jan 26 13:57:40 2001
> +++ linux-2.4.0/drivers/sound/sb.h	Fri Jan 26 13:58:42 2001
> @@ -137,6 +137,8 @@
>  	   void (*midi_input_intr) (int dev, unsigned char data);
>  	   void *midi_irq_cookie;		/* IRQ cookie for the midi */
>  
> +	   spinlock_t lock;
> +
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
