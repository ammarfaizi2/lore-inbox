Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTGKRnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTGKRnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:43:03 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:7592 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S264543AbTGKRnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:43:01 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Date: Fri, 11 Jul 2003 18:57:49 +0100
User-Agent: KMail/1.5.9
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307111857.49762.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 18:47, Arjan van de Ven wrote:
> On Fri, 2003-07-11 at 19:40, Alistair J Strachan wrote:
> > o The state of kbuild in shipped (distribution) kernels must be such that
> > the construction of external modules can be done without having to modify
> > the shipped kernel-source package.
>
> that is actually not hard; I just did this in a RH rpm like way last
> week.

I cannot see how you can make modversions modules without first building
vmlinux. This "RPM" presumably does not ship with vmlinux constructed, and
modpost depends on vmlinux to extract dependency symbols (as far as I can
tell.. though a KBUILD run on an uncompiled modversions tree appears to work,
you'll find the modversions section is not added to the kernel module, note
the size difference).

Try it with the NVIDIA driver, or any other preexisting driver using kbuild
and modversions but lacking a prebuilt vmlinux. I don't use RH, but
presumably the distributed 2.4 kernels did not have to be built before you
could include modversions.h. Assuming modpost is now a replacement for
modversions.h, and it does require vmlinux to include symbol CRCs, no, I
would say there was a problem.

> > So far, this matches the behaviour in 2.4. However, in 2.4 you need only
> > do a "make dep" (and, I believe, some distros also touch a couple of
> > other files).
>
> you never ever should need to do make dep in distro trees for building
> external modules.

Probably not, but what I meant was that supporting files (such as autoconf.h
and other "generated" headers that ARE required for compilation) would be
made during such a stage in 2.4 and do not have to be rebuilt. This isn't
actually the main issue, but I did notice that modpost is sometimes rebuilt
when you call the kernel makefile with SUBDIRS=/to/external/directory, and I
think it's obvious that this will require write access to the tree.

Cheers,
Alistair.

