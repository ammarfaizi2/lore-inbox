Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266491AbSLRRjc>; Wed, 18 Dec 2002 12:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267111AbSLRRjc>; Wed, 18 Dec 2002 12:39:32 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:60840 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266491AbSLRRjb>; Wed, 18 Dec 2002 12:39:31 -0500
Date: Wed, 18 Dec 2002 11:47:26 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: vamsi@in.ibm.com, Zwane Mwaikambo <zwane@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
In-Reply-To: <20021218022816.913AC2C238@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0212181144120.21707-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002, Rusty Russell wrote:

> In message <20021217114846.A30837@in.ibm.com> you write:
> > On Tue, Dec 17, 2002 at 11:17:05AM +1100, Rusty Russell wrote:
> > > 
> > > BTW, this was done for (1) simplicity, (2) so KBUILD_MODNAME can be
> > > used to construct identifiers, and (3) so parameters when the module
> > > is built-in have a consistent name.
> > > 
> > Ok, I see it now, this magic happens in scripts/Makefile.lib. 
> > My module has been built outside the kernel build system, that's
> > why I saw this problem.
> > 
> > I guess avoiding '-' should do it, but is there a simple way to 
> > correctly build (simple, test) modules outside the kernel tree now?
> 
> Has there ever been a simple way?

Well, you can do

cd my_module
echo "obj-m := my_module.o" > Makefile
vi my_module.c
make -C <path/to/kernel/src> SUBDIRS=$PWD modules

That's not too bad (and basically works for 2.4 as well)

--Kai


