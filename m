Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293631AbSCPBCC>; Fri, 15 Mar 2002 20:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCPBBw>; Fri, 15 Mar 2002 20:01:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52240 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293631AbSCPBBe>; Fri, 15 Mar 2002 20:01:34 -0500
Date: Fri, 15 Mar 2002 17:00:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anders Gustafsson <andersg@0x63.nu>
cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <20020316005736.GB31421@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.LNX.4.33.0203151659060.1379-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Anders Gustafsson wrote:
>
> this patch fixes "undefined reference to `local symbols in discarded
> section .text.exit'" linking error.

Looking more at this, I actually think that the _real_ fix is to call all
drivers exit functions at kernel shutdown, and not discard the exit
section when linking into the tree.

That, together with the device tree, automatically gives us the
_correct_ shutdown sequence, soemthing we don't have right now.

Anybody willing to look into this, and get rid of that __devexit_p()
thing?

		Linus

