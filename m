Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312409AbSDJJG5>; Wed, 10 Apr 2002 05:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDJJG4>; Wed, 10 Apr 2002 05:06:56 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:30418 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S312409AbSDJJGz>; Wed, 10 Apr 2002 05:06:55 -0400
From: <benh@kernel.crashing.org>
To: Peter Horton <pdh@berserk.demon.co.uk>, <linux-kernel@vger.kernel.org>
Cc: <phorton@bitbox.co.uk>, <ajoshi@unixbox.com>
Subject: Re: [PATCH] Radeon frame buffer driver
Date: Wed, 10 Apr 2002 11:06:38 +0200
Message-Id: <20020410090638.1550@mailhost.mipsys.com>
In-Reply-To: <20020410001249.GA2010@berserk.demon.co.uk>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Another installment of the Radeon frame buffer driver patch (still
>against 2.4.19-pre2).
>
>* All colour modes > 8bpp are now DIRECTCOLOR (Geert inspired).
>
>* Driver now uses 'ypan' to speed up scrolling even further.
>
>* Fix CRTC pitch to match accelerator pitch (800x600x256 works again).
>
>Driver seems okay now, plays nicely with X etc. etc. Please test if you
>can
>
>P.

I really don't like all the hacks related to the palette in 15/16/32bpp 
mode. You shouldn't affect whatever palette gets passed from userland or
apps that rely on full access to the gamma table will fail. Also, iirc,
the chip's palette in 16 bits mode is 64 entries and 32 in 15 bpp, you
can verify this by seeing how much entries get passed by xfbdev when
it configures the 1:1 color ramp. The old code worked except for the
cursor in console mode which tends to have crazy colors, I think due to
fbdev code brokenness but I'm too sure about that last one.

Ben.




