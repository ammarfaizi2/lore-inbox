Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSBMRRd>; Wed, 13 Feb 2002 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSBMRRV>; Wed, 13 Feb 2002 12:17:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17677 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287865AbSBMRRR>; Wed, 13 Feb 2002 12:17:17 -0500
Date: Wed, 13 Feb 2002 11:02:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6A9DEA.5D89D739@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202131059250.13632-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, Jeff Garzik wrote:
>
> Applying a patch like s/virt_to_bus/virt_to_phys/ makes it more
> difficult to find the right spots to change later.

Yes and no.

The thing is, for architectures that care, you can just grep for
"virt_to_phys()". It's basically _never_ the right thing to do on
something like sparc.

My personal preference would actually be to keep "virt_to_bus()" for x86
for now, and undo the change to make it complain. Instead, make it
complain on other architectures where it _is_ wrong, so that you don't
have to fix up drivers that simply aren't an issue. What's the point of
breaking some drivers that only exist on x86?

That, together with a warning and educating more driver writers.

		Linus

