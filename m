Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbRFZVS2>; Tue, 26 Jun 2001 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbRFZVSS>; Tue, 26 Jun 2001 17:18:18 -0400
Received: from euclide.bretagne.ens-cachan.fr ([193.52.92.2]:14780 "EHLO
	euclide.bretagne.ens-cachan.fr") by vger.kernel.org with ESMTP
	id <S264853AbRFZVSO>; Tue, 26 Jun 2001 17:18:14 -0400
To: jsimmons@transvirtual.com (James Simmons)
Cc: Linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106261324280.30394-100000@transvirtual.com>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbgen & multiple RGBA
From: dolbeaur@club-internet.fr (Romain Dolbeau)
Reply-To: dolbeau@irisa.fr
Date: Tue, 26 Jun 2001 23:17:34 +0200
Message-ID: <1evmtnt.1yhx1hb1pz56vyM%dolbeaur@club-internet.fr>
Organization: IRISA
User-Agent: MacSOUP/F-2.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This happens every time you VC switch.
[snip]
> But because of the way the current console system
> is designed the colormap will always be set on VC switches.

The fix wasn't intended for VC switch, but for any change of
fb_var_screeninfo parameter. Those can happen without VC switching,
that's exactly what 'fbset' is for.

If on your console you do a 'fbset -depth 16 -rgba 5,6,5,0' followed by
a 'fbset -depth 16 -rgba 5,5,5,1' [1], any driver using fbdev will end
up with a crazy colormap because it hasn't been reinstalled after the
RGBA change.

Hence the need for the fix.

[1] yes, in fbset, "-depth" really mean "-bpp" ...

-- 
DOLBEAU Romain               |
ENS Cachan / Ker Lann        | l'histoire est entierement vraie, puisque
Thesard IRISA / CAPS         |     je l'ai imaginee d'un bout a l'autre
dolbeaur@club-internet.fr    |           -- Boris Vian
