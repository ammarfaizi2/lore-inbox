Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTLOSWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTLOSWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:22:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:33964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263918AbTLOSWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:22:50 -0500
Date: Mon, 15 Dec 2003 10:22:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Toad <toad@amphibian.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
In-Reply-To: <3FDDD923.30509@pobox.com>
Message-ID: <Pine.LNX.4.58.0312151019160.1488@home.osdl.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
 <Pine.LNX.4.58.0312150715410.1488@home.osdl.org> <3FDDD923.30509@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Jeff Garzik wrote:
>
> Pardon me for asking a dumb and possibly impertinent question, but why
> keep it around at all?

Hey, I've tried to kill it off, but people keep on wanting it. Either
because they are lazy and can't upgrade the tools to write CD's with the
regular ide-cd interfaces, or because they have IDE tapes and want to use
st.c to drive them.

ide-cd.c obviously does _not_ handle tapes. We could make the generic IDE
layer open them and let people do SCSI commands on them (and that probably
wouldn't be too hard), but somebody needs to _care_.

Right now ide-scsi (and the alternatives, like doing SCSI commands onto
any ATAPI device just using the regular IDE layer) are mostly hampered by
people complaining about them but not actually _doing_ anything.

I'll try something that rips out the reset handling altogether from
ide-scsi, let's see how that works (should be easy enough to test with a
black marker and an old CD-ROM).

		Linus
