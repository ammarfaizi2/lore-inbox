Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVIRUgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVIRUgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVIRUgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:36:21 -0400
Received: from iabervon.org ([66.92.72.58]:47877 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932192AbVIRUgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:36:20 -0400
Date: Sun, 18 Sep 2005 16:40:35 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
In-Reply-To: <9a87484905091718163bb72e58@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0509181604460.23242@iabervon.org>
References: <m364szk426.fsf@defiant.localdomain>  <9a874849050917174635768d04@mail.gmail.com>
  <m3d5n7kwwz.fsf@defiant.localdomain> <9a87484905091718163bb72e58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Jesper Juhl wrote:

> On 18 Sep 2005 03:05:32 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> > Jesper Juhl <jesper.juhl@gmail.com> writes:
> > 
> > > What exactely is it you want to make a sepperate package?
> > 
> > Just the menuconfig (mconf) at first. OTOH it might make sense to
> > move them all.
> > 
> 
> And if you do that, then you'd be shipping a kernel source that it
> would be impossible for users to configure without installing
> sepperate tools - and tools (unlike for example gcc) that very few
> people would have a need for outside configuring their kernel.
> Not a good idea in my oppinion.

There are, in my opinion, two issues: where is kconfig maintained, and is 
it shipped with the kernel. I think each kernel tarball should contain the 
version of kconfig it expects to be configured with, because there isn't a 
commitment to having kconfig be compatible between versions. On the other 
hand, I don't see any reason that it has to be maintained in the kernel's 
git repositories.

Git actually supports this. Sam could have a repository with only the 
kbuild files, and people could pull it normally, and it would all work 
trivially (so long as people didn't try to modify kbuild by sending 
patches to Linus). The only tricky thing is that this repository can't 
have the linux-with-kbuild repository as an ancestor, because then it 
would remove stuff; so, if people want kbuild history, it would need to be 
recreated separately.

The advantage would be that people who wanted the latest version of kbuild 
could always get it without the kernel; the disadvantage is that kernel 
developers who want to change kbuild would have to remember not to send 
this changes into the kernel tree. I don't know if it would be more or 
less convenient for Sam not to have the rest of the kernel tree around 
kbuild.

	-Daniel
*This .sig left intentionally blank*
