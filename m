Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWBVTa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWBVTa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWBVTa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:30:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2526 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751274AbWBVTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:30:27 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Gabor Gombas <gombasg@sztaki.hu>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
In-Reply-To: <20060222191832.GA14638@suse.de>
References: <20060221153305.5d0b123f.akpm@osdl.org>
	 <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org>
	 <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	 <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	 <20060222112158.GB26268@thunk.org>
	 <20060222154820.GJ16648@ca-server1.us.oracle.com>
	 <20060222162533.GA30316@thunk.org>
	 <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	 <20060222185923.GL16648@ca-server1.us.oracle.com>
	 <20060222191832.GA14638@suse.de>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 20:29:48 +0100
Message-Id: <1140636588.2979.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 11:18 -0800, Greg KH wrote:
> On Wed, Feb 22, 2006 at 10:59:23AM -0800, Joel Becker wrote:
> > On Wed, Feb 22, 2006 at 06:33:54PM +0100, Gabor Gombas wrote:
> > > I don't think isnmod is broken. It's job is to load a chunk of code into
> > > the kernel, and it's doing just that.
> > > 
> > > ...
> > >
> > > But if your kernel has CONFIG_HOTPLUG enabled, then _you_ have asked for
> > > this exact behavior, therefore you should better fix userspace to cope
> > > with it. Your initrd should use the notification mechanisms provided by
> > > the kernel to wait for the would-be root device really becoming
> > > available; if it's not doing that, then IMHO you should not use a
> > > CONFIG_HOTPLUG enabled kernel.
> > 
> >         The issue isn't so much "insmod is right" vs "insmod is wrong".
> > It's that the behavior changed in a surprising fashion.  Red Hat's
> > kernel for RHEL4 (in our example) has CONFIG_HOTPLUG=y, yet it Just
> > Works.  A more recent kernel (.15 and .16 at least) with
> > CONFIG_HOTPLUG=y doesn't work.  Same disk drivers.  Same initramfs
> > script.
> 
> RHEL is a very different kernel from mainline (just like SLES is).  Have
> you looked through their patches to see if they are including something
> that causes this behavior?

I doubt it does; rhel isn't that much patches...

> 
> What about trying a stock 2.6.6 or so kernel?  Does that work
> differently from 2.6.15?

... however it's very much designed only for the kernel that comes with
it (with "it's" I mean all the userspace infrastructure); all the
changes and additions since 2.6.9 aren't incorporated so you probably
really want new alsa, new initscripts, new mkinitrd, new
module-init-tools. some because of abi changes since 2.6.9, others
because the kernel grew capabilities that are really needed for "nice"
behavior.


