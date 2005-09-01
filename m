Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVIARWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVIARWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVIARWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:22:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51886 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030250AbVIARWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:22:15 -0400
Message-ID: <43173894.7040304@us.ibm.com>
Date: Thu, 01 Sep 2005 10:21:24 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Paul <brian.paul@tungstengraphics.com>
CC: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
References: <9e47339105083009037c24f6de@mail.gmail.com>	<1125422813.20488.43.camel@localhost>	<20050831063355.GE27940@tuolumne.arden.org>	<1125512970.4798.180.camel@evo.keithp.com>	<20050831200641.GH27940@tuolumne.arden.org>	<1125522414.4798.222.camel@evo.keithp.com>	<20050901015859.GA11367@tuolumne.arden.org>	<1125547173.4798.289.camel@evo.keithp.com>	<43171D33.9020802@tungstengraphics.com> <1125590991.15768.55.camel@localhost.localdomain> <4317268B.20306@tungstengraphics.com>
In-Reply-To: <4317268B.20306@tungstengraphics.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brian Paul wrote:

> It's other (non-orientation) texture state I had in mind:
> 
> - the texel format (OpenGL has over 30 possible texture formats).
> - texture size and borders
> - the filtering mode (linear, nearest, etc)
> - coordinate wrap mode (clamp, repeat, etc)
> - env/combine mode
> - multi-texture state

Which is why it's such a good target for code generation.  You'd
generate the texel fetch routine, use that to generate the wraped texel
fetch routine, use that to generate the filtered texel fetch routine,
use that to generate the env/combine routines.

Once-upon-a-time I had the first part and some of the second part
written.  Doing just that little bit was slightly faster on a Pentium 3
and slightly slower on a Pentium 4.  I suspect the problem was that I
wasn't caching the generated code smart enough, so it was it trashing
the CPU cache.  The other problem is that, in the absence of an
assembler in Mesa, it was really painful to change the code stubs.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDFziUX1gOwKyEAw8RAhmFAJ9QJ7RTrB2dHV/hwb8ktwLyqKSM4wCdGtbS
b0A2N2jFcLeg8HRm53jMyrI=
=Ygkd
-----END PGP SIGNATURE-----
