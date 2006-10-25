Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423275AbWJYLYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423275AbWJYLYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423277AbWJYLYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:24:41 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:37603 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1423275AbWJYLYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:24:40 -0400
Date: Wed, 25 Oct 2006 15:25:34 +0400
Message-Id: <200610251125.k9PBPYMj020655@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Arnd Bergmann <arnd@arndb.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roman Kagan <rkagan@sw.ru>
CC: Randy Dunlap <rdunlap@xenotime.net>
CC: Dmitry Mishin <dim@openvz.org>
CC: Andi Kleen <ak@suse.de>
CC: Vasily Averin <vvs@sw.ru>
CC: Christoph Hellwig <hch@infradead.org>
CC: Kirill Korotaev <dev@openvz.org>
CC: OpenVZ Developers List <devel@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
References: <200610251003.k9PA38kD018604@vass.7ka.mipt.ru> <200610251303.50551.arnd@arndb.de>
In-Reply-To: <200610251303.50551.arnd@arndb.de>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Wed, 25 Oct 2006 15:23:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

> > +struct compat_if_dqblk {
> > +       compat_uint_t dqb_bhardlimit[2];
> > +       compat_uint_t dqb_bsoftlimit[2];
> > +       compat_uint_t dqb_curspace[2];
> > +       compat_uint_t dqb_ihardlimit[2];
> > +       compat_uint_t dqb_isoftlimit[2];
> > +       compat_uint_t dqb_curinodes[2];
> > +       compat_uint_t dqb_btime[2];
> > +       compat_uint_t dqb_itime[2];
> > +       compat_uint_t dqb_valid;
> > +};
> > +
> > +/* XFS structures */
> > +struct compat_fs_qfilestat {
> > +       compat_uint_t dqb_bhardlimit[2];
> > +       compat_uint_t   qfs_nblks[2];
> > +       compat_uint_t   qfs_nextents;
> > +};
> > +
> 
> The patch looks technically correct, but you have defined the structures
> in a somewhat unusual way. I'd have defined them with 
> attribute((packed, aligned(4))) in the end.
> 
> Or even better, we should probably add a 
> 
> typedef unsigned long long __attribute__((aligned(4))) compat_u64;
> 
> for x86 compat and use that instead of compat_uint_t foo[2].

Actually I didn't use __attribute__, 'case I'v heard,  that this isn't
encouraged now to use __attribute__((...)) in kernel. But if you think it
is ok, and even preferable, I will definitely redo it!

Thanks!
