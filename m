Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268538AbTANCrc>; Mon, 13 Jan 2003 21:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268534AbTANCql>; Mon, 13 Jan 2003 21:46:41 -0500
Received: from dp.samba.org ([66.70.73.150]:45196 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268536AbTANCqB>;
	Mon, 13 Jan 2003 21:46:01 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: davidm@hpl.hp.com, Mike Stephens <mike.stephens@intel.com>,
       linux-kernel@vger.kernel.org, ralf@gnu.org
Subject: Re: Userspace Test Framework for module loader porting 
In-reply-to: Your message of "Mon, 13 Jan 2003 14:20:45 BST."
             <Pine.GSO.3.96.1030113114240.25230B-100000@delta.ds2.pg.gda.pl> 
Date: Tue, 14 Jan 2003 11:01:15 +1100
Message-Id: <20030114025453.5ECBB2C440@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.3.96.1030113114240.25230B-100000@delta.ds2.pg.gda.pl> you 
write:
> On Mon, 13 Jan 2003, Rusty Russell wrote:
> 
> > > I'm also a bit worried about changing module loaders so often.  Yeah,
> > > once you switch to a kernel-loader, presumably users won't be
> > > affected, but (kernel-module) developers will be.
> 
> Hmm, what's the gain from using shared objects as opposed to relocatables
> and why is there any for non-PIC objects at all?

[ Other maintainers dropped from CC, they're probably not that interested ].

Basically it comes down to ET_DYNs being designed to be easy to load.
For most archs, new sections don't have to be allocated (eg. plt,
GOT).  Sections don't have to be sorted, or layed out.  As you point
out, relocations are bundled nicely together, etc.

On some architectures, making the linker do more of the work makes a
significant difference (eg. in ia64 it generates the stub code to jump
out of modules).  The module being layed out continuously, however,
means we need a "vmalloc_truncate" to free init sections (except for
archs which use their own alloc functions anyway).

Like most things, it's a tradeoff.  19 archs makes it even more complex.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
