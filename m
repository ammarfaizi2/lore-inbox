Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310335AbSCLCeK>; Mon, 11 Mar 2002 21:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310339AbSCLCeA>; Mon, 11 Mar 2002 21:34:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23315 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310335AbSCLCdr>; Mon, 11 Mar 2002 21:33:47 -0500
Date: Mon, 11 Mar 2002 18:19:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <andersen@codepoet.org>, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D5ECD.6090108@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
> You have convinced me that unconditional filtering is bad.  But I still
> think people should be provided the option to filter if they so desire.

Hey, choice is always good, except if it adds complexity.

The problem with conditional filtering is that either it is a boot (or
compile time) option, or it is a dynamic filter.

If its a dynamic filter, and you don't trust root, what _are_ you going to
trust? The root program you don't trust might as well be turning the
filtering off because it wants to be "convenient". And since the only
programs you really want to filter are _exactly_ the kinds of programs
that want to avoid filtering, you're just hosed.

That's my real beef with this whole idiotic parsing thing. Either it is
fixed (bad, if you don't know what the commands are for all disks) or it
is trivially overcome in the name of "convenience" (equally bad, since it
makes the whole thing pointless).

None of these issues really exist in your networking example.

Trust me, I'm not trying to be difficult, I'm just pointing out the
fundamental problems of your approach.

Yeah yeah. You can add additional levels of protection, and we have
capabilities.

Add a special password-protected capability, so that only YOU can enable
certain hardware access stuff. Where does it end? Is one such capability
enough? How do you initialize the default values for the system if you
need to be there to type in the password at bootup every time? We're
talking about some rather fundamental things here, and these are issues
that go _far_ beyond some silly ATA stack layer.

		Linus

