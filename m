Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292322AbSBPItO>; Sat, 16 Feb 2002 03:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292325AbSBPItE>; Sat, 16 Feb 2002 03:49:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58125 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292322AbSBPIss>;
	Sat, 16 Feb 2002 03:48:48 -0500
Message-ID: <3C6E1CEE.261E1B06@mandrakesoft.com>
Date: Sat, 16 Feb 2002 03:48:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: perex@suse.cz
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: ALSA locking bug...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew spotted this one...  ALSA needs to be using a standard kernel
primitive... semaphore maybe?  :)

include/sound/core.h:
> static inline void snd_power_lock(snd_card_t *card, int can_schedule)
> {
>         while (test_and_set_bit(0, &card->power_lock)) {
>                 if (can_schedule) {
>                         set_current_state(TASK_INTERRUPTIBLE);
>                         schedule_timeout(1);
>                 }
>         }
> }

Thanks much for all the ALSA work, as a [former] audio driver hacker, it
is a relief in many ways :)

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
