Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267468AbUH0TSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUH0TSC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUH0TR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:17:56 -0400
Received: from mho.net ([64.58.22.200]:64449 "EHLO es1036.belits.com")
	by vger.kernel.org with ESMTP id S267418AbUH0TNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:13:34 -0400
Date: Fri, 27 Aug 2004 13:12:29 -0600 (MDT)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@es1840.belits.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408271254300.9525@es1840.belits.com>
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>
  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>  <20040827094346.B29407@infradead.org>
  <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
 <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Linus Torvalds wrote:

> But Greg is right - we don't keep hooks that are there purely for binary
> drivers. If somebody wants a binary driver, it had better be a whole
> independent thing - and it won't be distributed with the kernel.

  pwcx module was never distributed with the kernel, so the whole problem
is with the existence of hooks that it uses in the pwc driver (that is
usable on its own). I agree that it's not a good idea to keep hooks in the
driver that are unlikely to be used by anything other than proprietary
codecs and converters. However IIRC, V4l2 was supposed to have a userspace
codec interface, that, if actually implemented, would completely replace
the functionality of pwc to pwcx interface -- and do it in a cleaner
manner, too.

  I really don't understand why it wasn't done already because clearly
there is a need to support devices with builtin compression, both open and
proprietary, in a consistent manner. However since it was not done, maybe
it's a better idea to use the situation as a testbed for v4l2 codecs
interface, and keep the kernel hook until the v4l2 interface with a
userspace codec is released as a replacement. Then we can have a usable
driver, and codecs will be moved to where they belong.

  The issue of codecs being proprietary is separate, and even if they will
be opened, it will be still a bad idea to keep them in the kernel. It also
would be inconsistent with other decisions where all kinds of conversions,
even trivial ones, were moved into userspace.

-- 
Alex
