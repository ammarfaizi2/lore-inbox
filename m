Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270760AbRHNTex>; Tue, 14 Aug 2001 15:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270758AbRHNTeo>; Tue, 14 Aug 2001 15:34:44 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:3086 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270760AbRHNTec>; Tue, 14 Aug 2001 15:34:32 -0400
Message-ID: <3B797D8B.8682A077@t-online.de>
Date: Tue, 14 Aug 2001 21:35:39 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make psaux reconnect adjustable
In-Reply-To: <200108141829.SAA108540@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     From Gunther.Mayer@t-online.de Tue Aug 14 19:10:40 2001
> 
>     >     I can confirm what you suggest:
>     >         My mouse (Logitech wheel USB/PS2) sends indeed AA 00.
>     >     So, I extended my patch:
>     >     psmouse_reconnect = 0: Do nothing (just pass all to userspace)
>     >     psmouse_reconnect = 1: Flush Q & ping mouse on AA 00 (default)
>     >     psmouse_reconnect = 2: Flush Q & ping mouse on AA (old behaviour)
>     >
>     >     With reconnect 1 or 2: After reconnecting, mouse behaves strange
>     >         (jumping around the screen)
> 
>     This is a serious bug in many user-space drivers. PS/2 mouse protocol
>     was designed to easily re-synchronize (think about transmission errors/
>     lost bytes).
> 
> The fragment of text you reply to is not about the 3-byte PS/2
> protocol, but about the 4-byte wheelmouse protocol.

No, it applies even to 4-byte protocol (see 1).

1) Re-synchronize on transmission errors (e.g. lost bytes)
The 4-byte protocol shares bytes 1-3 with the 3-byte protocol.
So it can synchronize just as easy.

2) Re-connecting the mouse
The 4-byte wheelmouse protocol must be re-enabled by sending proper
magic bytes by user-level driver (else it stays in 3-byte mode).

_This_ shows, user-mode must be notified of the re-connect! So letting
the driver choose PS2_TRANSPARENT, it can easily handle this situation.

3) Re-connecting a different animal
The user-level driver should autodetect common mouse protocols
(legacy proprietary protocols will vanish and should not hinder progress).
