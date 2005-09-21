Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVIUDX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVIUDX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVIUDX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:23:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13803 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750762AbVIUDX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:23:57 -0400
Date: Wed, 21 Sep 2005 04:23:53 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
Message-ID: <20050921032353.GU7992@ftp.linux.org.uk>
References: <20050826145749.03BFE24D661@zion.home.lan> <200508262204.43683.blaisorblade@yahoo.it> <20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk> <200509181400.35765.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509181400.35765.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 02:00:35PM +0200, Blaisorblade wrote:
> On Friday 26 August 2005 23:48, Al Viro wrote:
> > On Fri, Aug 26, 2005 at 10:04:43PM +0200, Blaisorblade wrote:
> > > And beyond that what? I cannot even think what's the rest *. And
> > > "obvious" doesn't hold with me.
> Al, while at it, can I get a bit of help from you?
> 
> We have a commented out version of 
> arch/um/drivers/mconsole_kern.c:mconsole_proc(), which is supposed to read 
> the contents of procfs from the internal kernel mount, rather than /proc (to 
> avoid being faked out by hppfs).
> 
> As remarked in comments, that code is broken (run on the host uml_mconsole 
> <umid> proc <filename>, which will call that code, for 4-5 times gives you an 
> oops inside UML). Can you help with that?

nd.mnt is what?  NULL?  There's your oops.

Grab fs/nfsctl.c::do_open() and s/nfsd/proc/g in there.  FWIW, it's probably
better off in libfs.c with fs type as argument...  For now, just copy it -
it's trivial and small enough; when I move the sucker to libfs, we'll
switch to that.  And lose that deactivate_super(), obviously - you won't
be touching superblock anymore.

And for pity sake, 

	...
		goto out;
	...
out: ;
}

is spelled
	...
		return;
	...
