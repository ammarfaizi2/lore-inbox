Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbSLRMuX>; Wed, 18 Dec 2002 07:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbSLRMuX>; Wed, 18 Dec 2002 07:50:23 -0500
Received: from services.cam.org ([198.73.180.252]:27478 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267236AbSLRMuT>;
	Wed, 18 Dec 2002 07:50:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Rusty Russell <rusty@rustcorp.com.au>, Dave Jones <davej@suse.de>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Date: Wed, 18 Dec 2002 07:57:53 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021218094714.43C712C076@lists.samba.org>
In-Reply-To: <20021218094714.43C712C076@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212180757.53583.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 18, 2002 04:46 am, Rusty Russell wrote:
> In message <20021218102004.A4947@suse.de> you write:
> > On Wed, Dec 18, 2002 at 06:07:48PM +1100, Rusty Russell wrote:
> >  > Dave, it's true that it's my fault, but I'm afraid it looks like your
> >  > bug 8).  This is most likely karma for not reporting bugs in the
> >  > module code when you had problems 8)
> >
> > Bah, my bad. 8)
>
> That's OK, you're in good company as the first I heard from Alan was
> that he gave up kernel work because "modules was so broken". 8(
>
> >  > static int __init agp_backend_initialize(struct pci_dev *dev)
> >  >
> >  > ....
> >  > int agp_register_driver (struct pci_dev *dev)
> >  > {
> >  > ....
> >  > 	ret_val = agp_backend_initialize(dev);
> >
> > Whoops. Thanks, fixed up here.
> > I'll bet I duped that bug in other places too, as I've rejigged
> > stuff around. I'll double check those paths in a mo.
> >
> >  > Ed, does it work if you take all the __init out of the agp code?
> >
> > My moneys on it working. The oops looked like it was jumping to oblivion
> > when it called agp_backend_initialize. So the new modutils discards
> > __init sections ? That's a new feature isn't it ?
>
> Yeah, kind of a bonus.  It's actually arch-dependent.
>
> I've added an item in my TODO list to check for relocations on the
> non-init section which point into the init sections.  It'd be cute.
> It'll probably never go into the main kernel, and it's no actually an
> error, you can imagine code which does:
>
> 	if (initializing)
> 		some_init_func();

Dave when you have this in a bk tree let me know and I will pull and 
verify it working here.

Thanks to both of you

Ed Tomlinson
