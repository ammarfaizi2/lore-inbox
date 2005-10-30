Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVJ3QoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVJ3QoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVJ3QoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:44:17 -0500
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:60174 "EHLO
	hiauly1.hia.nrc.ca") by vger.kernel.org with ESMTP id S932173AbVJ3QoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:44:16 -0500
Message-Id: <200510301642.j9UGgqp3000803@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static
To: bunk@stusta.de (Adrian Bunk)
Date: Sun, 30 Oct 2005 11:42:52 -0500 (EST)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: matthew@wil.cx, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051030155624.GG4180@stusta.de> from "Adrian Bunk" at Oct 30, 2005 04:56:24 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I really don't think it makes any difference.  Such a function (returning
> > always 0) is always going to be inlined, and the only difference between
> > static inline and extern inline is what happens when it can't be inlined.
> 
> On !alpha we are defining inline to __attribute__((always_inline)) for 
> any non-ancient gcc making this a zero difference.

It looks as if there are subtle differences between "always_inline"
and "extern inline".  From the GCC extensions document:

  [always_inline]
  Generally, functions are not inlined unless optimization is specified.
  For functions declared inline, this attribute inlines the function even
  if no optimization level was specified.

  [extern inline]
  If you specify both @code{inline} and @code{extern} in the function
  definition, then the definition is used only for inlining.  In no case
  is the function compiled on its own, not even if you refer to its
  address explicitly.  Such an address becomes an external reference, as
  if you had only declared the function, and had not defined it.

The primary difference between "static inline" and "extern inline"
is in what happens when the address of the function is referenced.
With "extern inline", you need a unique library function to resolve
external references.  With "static inline", you may end up with
multiple copies of a function if its address is taken.

> The bigger issue is that "extern inline" generates a warning with 
> -Wmissing-prototypes and I'm currently working on getting the kernel 
> cleaned up for adding this to the CFLAGS since it will help us to avoid 
> a nasty class of runtime errors.

The prototypes could be added.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
