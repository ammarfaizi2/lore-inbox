Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSGQUJj>; Wed, 17 Jul 2002 16:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSGQUJi>; Wed, 17 Jul 2002 16:09:38 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:41231 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316629AbSGQUJL>; Wed, 17 Jul 2002 16:09:11 -0400
Date: Wed, 17 Jul 2002 22:12:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format
In-Reply-To: <E17Utwm-0004Oy-00@starship>
Message-ID: <Pine.LNX.4.44.0207172146590.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 Jul 2002, Daniel Phillips wrote:

> > 1. Properly fixing module races: I'm playing with a init/start/stop/exit
> > model, this has the advantage that we can stop anyone from reusing a
> > module and we only have to wait for remaining users to go away until we
> > can safely unload the module.
>
> I'm satisfied that, for filesystems at least, all the module races can be
> solved without adding start/stop, and I will present code in due course.

The start/stop methods are not needed to fix the races, they allow better
control of the unload process.

> However, Rusty tells me there are harder cases than filesystems.  At this
> point I'm waiting for a specific example.

For filesystems it's only simpler because they only have a single entry
point, but the basic problem is always the same. We have to protect
against module load/unload and unregister. Without an interface change we
will have to add module owner pointers everywhere and we will see
contention on the unload_lock due to try_inc_mod_count.

bye, Roman

