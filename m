Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWGaOgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWGaOgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWGaOgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:36:17 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24212
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932344AbWGaOgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:36:16 -0400
From: Rob Landley <rob@landley.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initramfs:  Allow rootfs to use tmpfs instead of ramfs
Date: Mon, 31 Jul 2006 10:35:00 -0400
User-Agent: KMail/1.9.1
Cc: Hugh Dickins <hugh@veritas.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
References: <200607301808.14299.a1426z@gawab.com> <Pine.LNX.4.64.0607301750080.10648@blonde.wat.veritas.com> <44CCFF09.2000106@zytor.com>
In-Reply-To: <44CCFF09.2000106@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311035.01571.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am totally out of the loop here.  (BusyBox has been taking up all my time 
for months now...)

I thought rootfs already would be tmpfs whenever that was compiled into the 
kernel, but I suspect the kernel I was looking at to come to that conclusion 
wasn't vanilla.  Still, that implies this isn't the first patch out there to 
do this...

On Sunday 30 July 2006 2:48 pm, H. Peter Anvin wrote:
> There is some justification: embedded people would like to load 
> inittmpfs and then continue running.

Yup.  Embedded people who generally have no swap anyway.  (Swap to flash is a 
bad idea.)  However, I believe what they were after was the ability to limit 
the filesystem size so runaway logs don't trigger the OOM killer.

> The main issue -- which I am not sure what effect this patch has -- is 
> that we would really like to move initramfs initialization even earlier 
> in the kernel, so that it can include firmware loading for built-in 
> device drivers, for example.

I remember this was "pending" late last year.  Thought it had made it into 
2.6.16 or so.  I need _way_ more time to read the kernel list.  (I'm 50,197 
messages behind.  That's just silly...)

> Thus, if this patch makes it harder to push initramfs initialization 
> earlier, it's probably a bad thing.  If not, the author of the patch 
> really needs to explain why it works and why it doesn't add new 
> dependencies to the initialization order.
> 
> Saying "this is a trivial patch" and pushing it on the -stable tree 
> doesn't inspire too much confidence, as initialization is subtle.

It doesn't look like -stable material to me either.  It might be small enough 
to add to the current -devel cycle, but that's not my call.

Is there any current documentation on the kernel's init sequence other than 
reading init/main.c and friends?

> 	-hpa

Rob
-- 
Never bet against the cheap plastic solution.
