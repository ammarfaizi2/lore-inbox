Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVCYOmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVCYOmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVCYOmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:42:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7838 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261651AbVCYOmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:42:52 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
	<20050323174925.GA3272@zero>
	<Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
	<20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
	<d1v67l$4dv$1@terminus.zytor.com>
	<3e74c9409b6e383b7b398fe919418d54@mac.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Mar 2005 07:39:44 -0700
In-Reply-To: <3e74c9409b6e383b7b398fe919418d54@mac.com>
Message-ID: <m1k6nvpz67.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> Tommy Reynolds wrote:
> > Then it is broken in several ways.
> >
> > First, file systems are not required to implement ".." (only "." is
> > magical, ".." is a courtesy).
> 
> On Mar 24, 2005, at 14:59, H. Peter Anvin wrote:
> > Doesn't have anything to do with sorting order or US-ASCII, it has to
> > do with readdir order.  If nothing else, it would be highly surprising
> > if "." and ".." weren't first; it's certainly a de facto standard, if
> > not de jure.
> 
> IMHO, this is one of those cases where "Be liberal in what you accept
> and strict in what you emit" applies strongly.  New filesystems should
> probably always emit "." and ".." in that order with sane behavior,
> and new programs should probably be able to handle it if they don't. I
> would add ".." and "." to squashfs, just so that it acts like the rest
> of the filesystems on the planet, even if it has to emulate them
> internally.  OTOH, I think that the default behavior of find is broken
> and should probably be fixed, maybe by making the default use the full
> readdir and optionally allowing a -fast option that optimizes the
> search using such tricks.

Find is doing a full readdir.  It just looks at the link count
of the directory it is doing the readdir on and if it is the
minimal unix link count of 2 it knows it does not have to stat
directory entries to see if they are directories.

As I recall there is also special handling in find for link count
of 1 to automatically handle filesystems that don't follow the normal
unix conventions so every directory entry must be stated.

Eric
