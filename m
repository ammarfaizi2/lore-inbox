Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVDXK12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVDXK12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 06:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVDXK12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 06:27:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:11653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262303AbVDXK1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 06:27:16 -0400
Date: Sun, 24 Apr 2005 03:26:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: pavel@ucw.cz, drzeus-list@drzeus.cx, torvalds@osdl.org, pasky@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-Id: <20050424032622.3aef8c9f.akpm@osdl.org>
In-Reply-To: <20050423233809.GA21754@kroah.com>
References: <20050421162220.GD30991@pasky.ji.cz>
	<20050421232201.GD31207@elf.ucw.cz>
	<20050422002150.GY7443@pasky.ji.cz>
	<20050422231839.GC1789@elf.ucw.cz>
	<Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
	<20050423111900.GA2226@openzaurus.ucw.cz>
	<Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org>
	<426A7775.60207@drzeus.cx>
	<20050423220213.GA20519@kroah.com>
	<20050423222946.GF1884@elf.ucw.cz>
	<20050423233809.GA21754@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Sun, Apr 24, 2005 at 12:29:46AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > > A word of warning: in many ways it's easier to work with patches. In
> > > > > particular, if you want to have me merge from your tree, I require a
> > > > > certain amount of cleanliness in the trees I'm pulling from. All of the
> > > > > people who used to use BK to sync are already used to that, but for people
> > > > > who didn't historically use BK this is going to be a learning experience.
> > > > > 
> > > > 
> > > > Is there a summary available of the major issues here so that we who are
> > > > new to this can get up to speed fairly quickly?
> > > 
> > > The main issue is if you want to use git for development and accepting
> > > patches from others, you need to be used to not using that git tree to
> > > send patches to Linus.  To send patches to him, do something like the
> > > following:
> > > 	- export the patches from your git tree
> > > 	- pick and choose what you want to send off, cleaning up the
> > > 	  changelog comments and merging patches that need to be.
> > > 	- clone the latest copy of Linus's tree.
> > > 	- apply the patches to that tree.
> > > 	- make the tree public
> > > 	- generate an email with the diffs and send that off to lkml and
> > > 	  Linus.
> > > 
> > > Because of all of this, I've found that it is easier to use quilt for
> > > day-to-day development and acceptance of patches.  Then use git to build
> > > up trees for Linus to pull from.
> > > 
> > > But you might find your workflow is different :)
> > 
> > How does Andrew fit into this picture, btw? I thought all patches ought
> > to go through him... Is Andrew willing to pull from git trees? Or is
> > it "create one version for akpm, and when he ACKs it, create another
> > for Linus"?
> 
> Yeah, getting Andrew into the picture is a bit different.

Andrew has some work to do before he can regain momentum:

- Which subsystem maintainers will have public git trees?

- Which maintainers will continue to use bk?

- Can Andrew legally use the bk client?

- Can Andrew legally use a bk client which won't go phut at cset 65535?

- How do I do a bk `gcapatch' is there is no Linus bk tree to base it off?

- If none of the above, which maintainers will put up-to-date raw patches
  in places where Andrew can get at them?

I don't know how all this will pan out.  I guess the next -mm won't have
many subsystem trees and I'll gradually add them as things get sorted out.

>  Previously,
> with bk, I could just have him pull from my trees, and generate a patch
> from that.  And actually, with git that would work just as well, so if
> you make your git working trees public, he can pull from them and you're
> fine.

yup.

> But with quilt it's different.  That's why I make up a big patch which
> is the sum of my individual patches and put them on a public site.
> Right now you can see this at:
> 	kernel.org/pub/linux/kernel/people/gregkh-2.6/
> The patches in that directory are the "rolled up" ones.  The script
> there is what I use to build these patches, if you want to do something
> like it.

I could aggregate a subsystem maintainer's quilt series into -mm of
course.  That would be nicer than a huge rollup for both code reviewing and
for the old bsearch-to-find-the-regression process.

Of course, quilt-based patches can be checked into an SCM and publically
exported.   Lots of people do that.

> In the patches/ subdir below that one, is a mirror of my quilt patches
> directory, series file and all.  That way people can still see the
> individual patches if they want to.
> 
> Does this help some?  It's all still under flux as to how this all
> works, try something and go from there :)

Yes, it would be nice to have gregkh's patches in -mm as individual patches.

Of course, whatever gets done, I'd selfishly prefer that most (or even all)
subsystem maintainers work the same way and adopt the same work practices.

I guess it's too early to think about that, but if one maintainer (hint)
were to develop and document a good methodology and toolset, others might
quickly follow.


