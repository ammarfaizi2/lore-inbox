Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVBIRg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVBIRg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVBIRg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:36:27 -0500
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:27663 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261859AbVBIRgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:36:25 -0500
Date: Wed, 9 Feb 2005 11:35:34 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Peter Osterlund <petero2@telia.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Fix ALPS sync loss
Message-ID: <20050209173533.GA12011@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Osterlund <petero2@telia.com>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <200502081840.12520.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502081840.12520.dtor_core@ameritech.net>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Dmitry Torokhov on Tuesday, 08 February, 2005:
>Hi,
>Here is the promised patch. It turns out protocol validation code was
>a bit (or rather a byte ;) ) off.
>Please let me know if it fixes your touchpad and I believe it would be
>nice to have it in 2.6.11.

This patch seems to be working for me too.  Thanks a million, Dmitry!
  I owe you a beer some time.  :)

-Joseph

>===================================================================
>ChangeSet@1.2147, 2005-02-08 18:12:06-05:00, dtor_core@ameritech.net
>  Input: alps - fix protocol validation rules causing touchpad
>         to lose sync if an absolute packet is received after
>         a relative packet with negative Y displacement.
>  
>  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> alps.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>===================================================================
>diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>--- a/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
>+++ b/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
>@@ -198,8 +198,8 @@
> 		return PSMOUSE_BAD_DATA;
> 
> 	/* Bytes 2 - 6 should have 0 in the highest bit */
>-	if (psmouse->pktcnt > 1 && psmouse->pktcnt <= 6 &&
>-	    (psmouse->packet[psmouse->pktcnt] & 0x80))
>+	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
>+	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
> 		return PSMOUSE_BAD_DATA;
> 
> 	if (psmouse->pktcnt == 6) {

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
