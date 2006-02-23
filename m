Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWBWHGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWBWHGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 02:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWBWHGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 02:06:41 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7299 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750878AbWBWHGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 02:06:40 -0500
Date: Wed, 22 Feb 2006 23:07:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: cannot open initial console
Message-ID: <20060223070708.GC27645@sorel.sous-sol.org>
References: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com> <305c16960602222241m1a28a718l82cfe185772449be@mail.gmail.com> <305c16960602222246h27341bf9qf6e4a89c1f14505e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960602222246h27341bf9qf6e4a89c1f14505e@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matheus Izvekov (mizvekov@gmail.com) wrote:
> On 2/23/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > On 2/22/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> >         } else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
> > -               REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
> > +               REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
> >         }
> >  }
> >
> > Reversing this fixes the problem, double checked it. What was that
> > patch supposed to do anyway?
> 
> Adding Vitaly Fertman to this thread, as he is the one who seems to
> have submitted that patch.

It's attempting to properly automatically enable a reiserfs feature
supporting attributes (via chattr/lsattr interface).  When mounting
(w/out attrs mount option) a reiserfs that should support attrs, the
above patch fixes the value OR'd with s_mount_opt (which was incorrectly
the shift value rather than the shifted value).  This has been backed
out in current -stable queue, and was fixed in Linus' tree as well.

thanks,
-chris

