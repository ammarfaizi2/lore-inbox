Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTAZJQj>; Sun, 26 Jan 2003 04:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbTAZJQi>; Sun, 26 Jan 2003 04:16:38 -0500
Received: from angband.namesys.com ([212.16.7.85]:10887 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266771AbTAZJQi>; Sun, 26 Jan 2003 04:16:38 -0500
Date: Sun, 26 Jan 2003 12:25:50 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz, mason@suse.com
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030126122550.A17142@namesys.com>
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com> <20030124225320.5d387993.akpm@digeo.com> <20030125153607.A10590@namesys.com> <20030125151301.18b70ef3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125151301.18b70ef3.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Jan 25, 2003 at 03:13:01PM -0800, Andrew Morton wrote:
> > Also I think that taking BKL just to update some inode accounting stuff is kind of expensive,
> > so certainly better solution must exist.
> However, in reviewing it, I don't see exactly what's going on.  Because only
> one process is accessing the stat information of the fsx inode anyway?

Well, I came to conclusion that we have fsx doing truncate racing
with fsstress doing sync->iput->ext2_discard_prealloc()

> Yes, we need to rub out that i_bytes/i_blocks thing, replace it with an
> atomically updated loff_t, etc.  But I'd like to understand what the exact
> failure is first.  It _seems_ that stat has somehow seen a >4G value of
> stat->size, but how can this happen???

It's just become negative as we discarding prealloc twice.

Bye,
    Oleg
