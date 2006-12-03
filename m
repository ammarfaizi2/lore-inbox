Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424987AbWLCGCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424987AbWLCGCY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 01:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424988AbWLCGCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 01:02:23 -0500
Received: from 1wt.eu ([62.212.114.60]:20741 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1424987AbWLCGCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 01:02:22 -0500
Date: Sun, 3 Dec 2006 07:02:08 +0100
From: Willy Tarreau <w@1wt.eu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
Message-ID: <20061203060208.GA900@1wt.eu>
References: <4571CE06.4040800@popdial.com> <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr> <20061202211522.GB24090@1wt.eu> <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr> <20061202225528.GA27342@1wt.eu> <1165113438.5698.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165113438.5698.5.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 09:37:18PM -0500, Trond Myklebust wrote:
> On Sat, 2006-12-02 at 23:55 +0100, Willy Tarreau wrote:
> > I'm not saying initramfs is not powerful, and indeed your example is
> > the common way of parsing cmdline for me too. What I'm saying is that
> > before nfsroot stops being supported, we'll need a working replacement
> > (and not "### further parse $arg"), if possible within the kernel tree
> > so that people who used to build kernels to boot such machines will
> > still be able to build kernels for them, even if this implies using
> > an initramfs with some tools in it.
> > 
> > The real danger of removing support for in-kernel features like this
> > is to leave people with no solution at all (because they don't know
> > how to proceed), and their workarounds are often worse than the
> > problem that we tried to fix in the first place.
> 
> It hasn't been removed yet. However most distributions choose not to
> enable it because that would force them to compile the NFS client into
> the main kernel instead of leaving it as a module.

That's a valid point, but in fact, building with NFS client and serial
port support in the kernel on some archs is as common as building with
IDE driver and VGA console in the kernel on x86. With some architectures
used in light networked workstations, it's very common to boot from the
network (sparc & parisc come to mind, sorry to those I forgot), hence
this common practise.

> As for the initramfs support, hpa has assured me that his klibc
> distribution already has a full solution for NFS mounting on current
> kernels.

That's again where we see the limits of this ever-developping 2.6.
I'm not saying that doing this from initramfs+tools is a bad solution,
since it solves lots of problems, it's just that it is *much* different
from what was previously done.

People who have installed a distro on their machines will not be
able to upgrade their kernel past a certain point by hand. Upgrading
distro packages in such environments is generally not always an
option (particularly boot packages such as boot loader and kernel),
because the boot server is not necessarily running on the same
OS/distro, and sometimes the kernel needs different build options.

Then the remaining solution to get stability and security fixes
is often to [cross-]compile a more recent kernel, and to put it
on the boot server. Fortunately Adrian maintains 2.6.16 :-/

> Trond

Regards,
Willy

