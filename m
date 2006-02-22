Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWBVQLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWBVQLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWBVQLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:11:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39626 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932324AbWBVQLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:11:40 -0500
Date: Wed, 22 Feb 2006 16:11:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222161133.GA18059@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>
References: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140624187.2979.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140624187.2979.38.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 05:03:07PM +0100, Arjan van de Ven wrote:
> On Wed, 2006-02-22 at 07:44 -0800, Linus Torvalds wrote:
> 
> 
> [snip lots of good words about that breaking userspace ABIs is really
> horrible]
> 
> I absolutely agree with what you say. HOWEVER hal is also terminally
> broken. The thing they depend on is a *config option*. If they can't
> deal with that config option not being enabled in a graceful way, that's
> a series malfunction.
> 
> 
> (and no this is not an excuse for breaking userspace ABIs at all,
> although one can argue that this removing is almost the same as
> disabling the config option)

And to continue the rant: the broken mount uevent feature (which
can't work right) got in without any serious review through the
driver model tree.  just as all those break udev/etc patches that
cause all these userland breakages for those people brave enough
to use udev and surrounding bits.

Folks, we need to stop breaking sysfs interface all the time.  Having
attributes on objects is real nice from many perspectives, but it's
also a burden because the internal object model is now seen by the
outside world.  That means anything involving sysfs needs a careful
design not random patching as the driver model core people appear to
do.
