Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSHBV0D>; Fri, 2 Aug 2002 17:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSHBV0D>; Fri, 2 Aug 2002 17:26:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317152AbSHBV0C>; Fri, 2 Aug 2002 17:26:02 -0400
Date: Fri, 2 Aug 2002 14:29:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Banai Zoltan <bazooka@emitel.hu>, Alexander Viro <viro@math.psu.edu>,
       Thomas Molina <tmolina@cox.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <1028290998.18309.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0208021424520.2532-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Aug 2002, Alan Cox wrote:
>
> The PnPBIOS gdt setup changes I did are wrong somewhere.

Alan, in your PnP patches you seem to have changed the 

	"set_limit()"

to a 

	"_set_limit()"

which looks wrong (or at least doesn't look consistent with the notion of 
just doing the same code as before, except on all CPU's).

It _looks_ to me like the QX_SET_SET() macros should be have the "_" 
removed from the set_limit part. As it is, _set_limit() gets the address 
calculations wrong (because you don't cast it to "char *") and also gets 
the limit wrong (because you no longer do the page size adjustment).

Does it work with that small change? I have no idea about the pnpbios 
code, I'm just looking at Alan's diff.

		Linus

