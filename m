Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265592AbUEZNDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUEZNDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265599AbUEZNDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:03:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:55210 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265581AbUEZNBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:01:01 -0400
Date: Wed, 26 May 2004 15:00:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526130047.GF12142@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040526125300.GA18028@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 14:53:00 +0200, Arjan van de Ven wrote:
> On Wed, May 26, 2004 at 02:50:14PM +0200, Jörn Engel wrote:
> > 
> > Experience indicates that for whatever reason, big stack consumers for
> > all three contexts never hit at the same time.  Big stack consumers
> > for one context happen too often, though.  "Too often" may be quite
> > rare, but considering the result of a stack overflow, even "quite
> > rare" is too much.  "Never" is the only acceptable target.
> 
> Actually it's not mever in 2.4. It does get here there by our customers once
> in a while. Esp with several NICs hitting an irq on the same CPU (eg the irq
> context goes over it's 2Kb limit)
> 
> > done, a stack overflow will merely cause a kernel panic.  Until then,
> > I am just as conservative as Andreas.
> 
> actually the 4k stacks approach gives MORE breathing room for the problem
> cases that are getting hit by our customers...

For the cases you described, yes.  For some others like nvidia, no.
Not sure if we want to make things worse for some users in order to
improve things for others (better paying ones?).  I want the seperate
interrupt stacks, sure.  I'm just not comfy with 4k per process yet.

But I'll shut up now and see if I can generate better data over the
weekend.  -test11 still had fun stuff like 3k stack consumption over
some code paths in a pretty minimal kernel.  Wonder what 2.6.6 will do
with allyesconfig. ;)

Jörn

-- 
He who knows that enough is enough will always have enough.
-- Lao Tsu
