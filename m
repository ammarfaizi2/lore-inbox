Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289829AbSBSU2P>; Tue, 19 Feb 2002 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289832AbSBSU2B>; Tue, 19 Feb 2002 15:28:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56844 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289829AbSBSU1g>; Tue, 19 Feb 2002 15:27:36 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] hex <-> int conversion routines.
Date: 19 Feb 2002 12:27:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a4ucfg$tfa$1@cesium.transmeta.com>
In-Reply-To: <02021919493204.00447@jakob> <200202191902.g1JJ2wx28246@frodo.gams.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200202191902.g1JJ2wx28246@frodo.gams.co.at>
By author:    Bernd Petrovitsch <bernd@gams.at>
In newsgroup: linux.dev.kernel
>
> Jakob Kemi <jakob.kemi@telia.com> wrote:
> >> > +static __inline__ char inthex_nibble(int x)
> >> > +{
> >> > +	const char* digits = "0123456789abcdef";
> >> > +
> >> > +	return digits[x & 0x0f];
> >> > +}
> >>
> >> perhaps better do static const char *digits.
> >GCC doesn't copy const strings, as opposed to other const arrays.
> >So it should be fine as it is. GCC also reuse duplicated strings.
> 
> You could also do
>     return "0123456789abcdef"[x & 0x0f];
> though some will find it bad, ugly, wrong
> or make a file-global
>     static const char digits[] = "0123456789abcdef";
> 

Better yet...

extern const char inthex_digits[];
static __inline__ char inthex_nybble(int x)
{
	return inthex_digits[x & 15];
}

(Nibble = small amount of food; nybble = 4 bits.  It's a pun on
bite/byte.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
