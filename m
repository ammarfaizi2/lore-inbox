Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270843AbRHNVCn>; Tue, 14 Aug 2001 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270841AbRHNVC1>; Tue, 14 Aug 2001 17:02:27 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:55817 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270843AbRHNVCI>; Tue, 14 Aug 2001 17:02:08 -0400
Message-ID: <3B795B82.195CA42B@t-online.de>
Date: Tue, 14 Aug 2001 19:10:26 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] make psaux reconnect adjustable
In-Reply-To: <200108141112.LAA99888@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     From garloff@garloff.de Tue Aug 14 11:57:23 2001
> 
>     I can confirm what you suggest:
>         My mouse (Logitech wheel USB/PS2) sends indeed AA 00.
>     So, I extended my patch:
>     psmouse_reconnect = 0: Do nothing (just pass all to userspace)
>     psmouse_reconnect = 1: Flush Q & ping mouse on AA 00 (default)
>     psmouse_reconnect = 2: Flush Q & ping mouse on AA (old behaviour)
> 
>     With reconnect 1 or 2: After reconnecting, mouse behaves strange
>         (jumping around the screen)

This is a serious bug in many user-space drivers. PS/2 mouse protocol
was designed to easily re-synchronize (think about transmission errors/
lost bytes).

>     With reconnect 0:      Mouse is dead

This is a bug in all user-space drivers (understandable as the
kernel tried to be too clever). They must send the proper ps2-enabling
sequence after they see "aa 00".

> 
>     In both cases restarting gpm gets the mouse back to work again.
>     It seems the imps2 driver does some initialization to the mouse.
> 
>     If I use the plain ps2 driver, then finally, I see the benefit of the
>     reconnect code in the kernel:
>     With reconnect = 1 or 2: It works after replugging
>     With reconnect = 0:      Mouse is dead after replugging
> 
>     In the latter case restarting gpm helps.
...

Add an "ioctl(PS2_TRANSPARENT)", to disable the current kernel policy.
So new drivers which understand about "aa 00" sequences can act properly.
Don't break existing apps.
