Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbSLLExc>; Wed, 11 Dec 2002 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbSLLExc>; Wed, 11 Dec 2002 23:53:32 -0500
Received: from mail8.kc.rr.com ([24.94.162.176]:21768 "EHLO mail8.wi.rr.com")
	by vger.kernel.org with ESMTP id <S267396AbSLLExb>;
	Wed, 11 Dec 2002 23:53:31 -0500
Message-ID: <007e01c2a19b$934e9a00$6400a8c0@win01>
From: "Ted Kaminski" <mouschi@wi.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: pnp/IDE question- help fixing up a patch
Date: Wed, 11 Dec 2002 23:01:47 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've got an ide, and an idepnp question... (for 2.4)

I'm working on refining a patch sent previously
(http://groups.google.com/groups?selm=20021108061020.A14168%40localhost) to
be less intrusive. I'll be refering to things done in that patch...

The short of it is, this sb16 pnpide interface apparently cannot use
ALTSTATUS at a certain point. (I'm no ide whiz, I'm just simplifying the
code that David Meybohm wrote, so maybe I'm off a bit) at any rate, this
seems to require a new flag be listed along with the hardware information.

His solution was to add
+ int  no_passive;  /* no passive status tests */
to hw_reg_s in ide.h and check that flag in drive_is_ready()

I *think* it's out of place. It seems to me it'd be more appropriate to add
+ unsigned no_passive : 1;   /* no passive status tests */
to hwif_s in ide.h.  Right next to a few other bitfields

Which is better? or is there a different, even better spot?

As for the idepnp part, he added a "dev = NULL" into the loop, and was
unsure of whether or not this was a good idea.  I have the same question.
Or perhaps this smells of a seperate patch?

I'd rather ask these question in the form of my own patch, but... I'm a bit
short on time, atm. sorry.

Thanks in advace,
-Ted

