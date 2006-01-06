Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWAFHxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWAFHxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWAFHxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:53:10 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:12551 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964797AbWAFHxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:53:08 -0500
Date: Fri, 6 Jan 2006 08:53:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Deepak Saxena <dsaxena@plexity.net>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix EISA/VLB/PCI network controllers alignment in
 menuconfig
Message-Id: <20060106085315.79408ff7.khali@linux-fr.org>
In-Reply-To: <20060105205153.GB15968@flint.arm.linux.org.uk>
References: <20051227210628.0575f672.khali@linux-fr.org>
	<20060105205153.GB15968@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> On Tue, Dec 27, 2005 at 09:06:28PM +0100, Jean Delvare wrote:
> > The CS89x0 Kconfig entry currently breaks the alignment of all
> > "EISA, VLB, PCI and on board controllers" that follow it in menuconfig.
> > This patch fixes it.
> > 
> > This bug was introduced in version 2.6.13-rc1. A first, different fix
> > attempt was made by Deepak Saxena:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=712cb1ebb1653538527500165d8382ca48a7fca1
> > 
> > But it seems it was then overwritten by a subsequent (unsigned?) changeset
> > from Russell King:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e399822da0f99f8486c33c47e7ae0d32151461e5
> 
> It shouldn't have been overwritten - it's probably the result of a
> mis-merge.  I would appear that Deepak's change went in via one tree
> and mine via my own tree.
> 
> As far as that change being unsigned, I don't see why the removal of
> a previous addition would require a Sign-off.  We never signed-off
> for undoing BK changesets so I'm merely following the established
> modus operandi.

Given the original meaning of these "Signed-off-by" lines (certifying
that the added code belongs to the sender), it certainly makes sense.
However, we tend to now use these lines for a second meaning, which is
tracing all approvers of the patch from the author to the committer.
For that second meaning, signing reverts may make sense.

> I have no view on your patch since I never use any of the config
> tools apart from oldconfig.

Well, oldconfig is affected by the alignment bug as well. Try deleting
the lines of a few drivers depending on NET_PCI and placed after CS89x0
in .config (e.g. CONFIG_DGRS) and run "make oldconfig", you'll see it.

Aside from the alignment bug, what I really need to know is if the new
dependency expression I came up with it OK:
  NET_PCI && (ISA || ARCH_IXDP2X01 || ARCH_PNX0105)

If it is, then I guess that there is no point discussing any further
and the patch can be applied.

Thanks,
-- 
Jean Delvare
