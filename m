Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVAGQEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVAGQEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVAGQEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:04:23 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:46979 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261471AbVAGQEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:04:02 -0500
Date: Fri, 7 Jan 2005 17:03:59 +0100
From: Martin Mares <mj@ucw.cz>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107160359.GA6529@ucw.cz>
References: <20050107153328.GD28466@devserv.devel.redhat.com> <200501071541.j07FfeQC018553@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071541.j07FfeQC018553@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >yes; most distributions will use pam for this, you can set per user or per
> >gorup limits there.
> 
> isn't that a uid/gid based system? ok, i'm being a little snide :)

:)  The big difference between this and a pure uid/gid based system is that
pam_limits is not the only place where you can change the ulimits. If your
system is simple enough that deciding on uid/gid is enough, you can use
pam_limits; if not and you for example want to make the limits depend
on the phase of the moon, it's easy to do so -- just write a simple user space
program which will set the limits accordingly. Also, if the user wishes to
restrict his abilities, because he's going to do some experiment and he
doesn't want to lock up the machine, he can easily do so.

Except for filesystem permissions, I think that it's exactly the usual UNIX
way of controlling access -- the kernel takes care of access checks based
on some trivial attributes like ulimits and capabilities, and user space
decides who should get which. I don't see any reason why the right to use
realtime scheduling should be treated differently. Do you?

It's quite probable that the current system of capabilities is not well
suited for this, but I think that although it's tempting to work around it
by introducing a new security module, in the long term it's much better
to extend and/or fix the capabilities -- I don't see any fundamental reason
for capabilities being unusable for this goal, it's much more likely to be
just minor details in the implementation.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Always remember that you are absolutely unique ... just like everyone else.
