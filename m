Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbUCHA5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUCHA5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:57:11 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:9871 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S262359AbUCHA4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:56:47 -0500
Date: Sun, 7 Mar 2004 15:56:47 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0403071535290.1733@bifrost.nevaeh-linux.org>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004, Tim Schmielau wrote:

> But the current tools are only broken for the few people using high UIDs
> (and generally on 64 bit archs, but that's a different story).

This is broken on x86 as well.  I guess I still have to question the logic of
logging bad data, even if you think the data is infrequent at best.  Keep in
mind that in my environment I'm not using high UIDs because I actually have
that many accounts, I'm using them because each employee uses their employee
ID as their UID, which simplifies management for me.  Again, this most likely
isn't typical, but it's not irrational, either.

> We shouldn't require people to recompile their userspace tools in the
> middle of a stable kernel series. (OK, 2.6 has just started, but we don't
> want to offend people upgrading from 2.4, either.)

I can understand this argument, and I would certainly agree for things that
are commonly used.  But given the state of the BSD accounting tools (a package
that hasn't had a public update since 1998, and which has non-high uid broken
bits in it as well) I would hazard a guess that the impacted users is going to
be minimal, at best.

> How about the patch below? It requires a change to userspace tools if you
> want to use high uids, but it dosn't break binary compatibility. It even
> allows userspace to check whether high UIDs are supported, and allows
> future incompatible format changes to be detected.

I like it, and the addition of ac_version is a great idea.  I might alter the
comment about 64-bit machines in acct.c, though.  32-bit UIDs affects 32-bit
machines as well.

> Well, they are not totally meaningless since we clip at the maximum
> representable value instead of wrapping around.

:-P I don't look at this any different than the byte-clipping we're doing with
UIDs.  If we're logging data that's wrong, then you can't do accurate
accounting, period.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
