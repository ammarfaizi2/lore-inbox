Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293083AbSBWCZH>; Fri, 22 Feb 2002 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293084AbSBWCY7>; Fri, 22 Feb 2002 21:24:59 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:4358 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S293083AbSBWCYt>;
	Fri, 22 Feb 2002 21:24:49 -0500
Date: Sat, 23 Feb 2002 02:30:07 +0000
From: Ian Molton <spyro@armlinux.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conversion routines.
Message-Id: <20020223023007.7e929392.spyro@armlinux.org>
In-Reply-To: <a4ucfg$tfa$1@cesium.transmeta.com>
In-Reply-To: <02021919493204.00447@jakob>
	<200202191902.g1JJ2wx28246@frodo.gams.co.at>
	<a4ucfg$tfa$1@cesium.transmeta.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.2cvs8 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a sunny 19 Feb 2002 12:27:28 -0800 H. Peter Anvin gathered a sheaf of
electrons and etched in their motions the following immortal words:

> extern const char inthex_digits[];
> static __inline__ char inthex_nybble(int x)
> {
> 	return inthex_digits[x & 15];
> }

What about the following? It maintains the exact behaviour of the original,
but can be smaller if it doesnt have to deal with >15 in the input (then it
wont need the x &= 0x0f).

It would be 3 cycles for <10 and 4 for >=10 on ARM. I'd imagine this would
be a little quicker than a load from memory as in the above example.

plus it doesnt waste 16 bytes of RAM in a lookup table.

static inline char inthex_nybble(int x){
        x &= 0x0f;
        return  x<10?x^48:x+87;
}

Just a thought...
