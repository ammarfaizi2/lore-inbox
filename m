Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbUK3Npl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUK3Npl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUK3Npl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:45:41 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:3789 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262075AbUK3Npc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:45:32 -0500
Date: Tue, 30 Nov 2004 05:48:22 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] relinquish_fs() syscall
Message-ID: <20041130134822.GD63669@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com> <1101729087.20223.14.camel@localhost.localdomain> <20041129135559.GC33900@gaz.sfgoth.com> <41AC67B2.6010601@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AC67B2.6010601@hist.no>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 30 Nov 2004 05:48:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> So someone finds a way to break into the jailed process.
> This is used to feed some hairy exploit to the unjailed
> process that expects "clean" data from the jailed process.

OK, so by your logic firewalls are useless (since you can just exploit the
firewall and then the host)  Oh and you might as well run all your daemons
as root (since an attacker can just use some other exploit to gain root
later)

The entire point of a privsep design is that the unjailed process treats
all data from the jailed process as untrusted.  If the attacker gains
full control of the jailed process it should still be a challenge to
trick the unjailed process into doing something harmful.

> Same as before, only now they need a two-stage exploit.

Exactly!  Now in order for the attacker to win they need to find a
programming error in the jailed process AND the unjailed process.
This is how defense in depth works.

> You can jail a process doing a "dangerous" job, but you can't
> really jail a "hairy" data stream.  Not if data is expected to
> emerge from the jail someday.

That's a bogus argument - the data exiting the jail can come out in a
non-hairy format that is less error-prone to process.  You do all the
complicated crypto/compression/parsing/etc inside the jail where a
programming errors cause less damage.

Think about a client communicating with a random network hosts over an
SSL connection - you can move the SSL engine into the jailed process.
Now if your SSL's ASN.1 parser has a buffer overflow and you connect to
a malicious server it can't immediately compromise your account.

-Mitch
