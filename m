Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270566AbRHNLMt>; Tue, 14 Aug 2001 07:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270567AbRHNLMk>; Tue, 14 Aug 2001 07:12:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31116 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S270566AbRHNLMY>;
	Tue, 14 Aug 2001 07:12:24 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 14 Aug 2001 11:12:29 GMT
Message-Id: <200108141112.LAA99888@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, garloff@suse.de
Subject: Re: [PATCH] make psaux reconnect adjustable
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mantel@suse.de,
        rubini@vision.unipv.it, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From garloff@garloff.de Tue Aug 14 11:57:23 2001

    I can confirm what you suggest:
	My mouse (Logitech wheel USB/PS2) sends indeed AA 00.
    So, I extended my patch:
    psmouse_reconnect = 0: Do nothing (just pass all to userspace)
    psmouse_reconnect = 1: Flush Q & ping mouse on AA 00 (default)
    psmouse_reconnect = 2: Flush Q & ping mouse on AA (old behaviour)

    With reconnect 1 or 2: After reconnecting, mouse behaves strange
	(jumping around the screen)
    With reconnect 0:      Mouse is dead

    In both cases restarting gpm gets the mouse back to work again.
    It seems the imps2 driver does some initialization to the mouse.

    If I use the plain ps2 driver, then finally, I see the benefit of the
    reconnect code in the kernel:
    With reconnect = 1 or 2: It works after replugging
    With reconnect = 0:      Mouse is dead after replugging

    In the latter case restarting gpm helps.

Before having an opinion about what would be appropriate,
let me make sure that I understand the facts that you report.

You talk about reconnect, but what is your definition of reconnect?
Is it that the mouse sends AA or AA 00, or is it that you unplug
and replug the mouse?

Andries
