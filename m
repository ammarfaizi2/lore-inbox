Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVIVJWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVIVJWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVIVJWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:22:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030225AbVIVJWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:22:37 -0400
Date: Thu, 22 Sep 2005 02:21:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Kernel panic during SysRq-b on Alpha
Message-Id: <20050922022152.0c0f0c97.akpm@osdl.org>
In-Reply-To: <20050922130449.A29503@jurassic.park.msu.ru>
References: <43315BEB.3010909@ens-lyon.org>
	<20050922101259.A29179@jurassic.park.msu.ru>
	<20050921234232.1034cc02.akpm@osdl.org>
	<20050922130449.A29503@jurassic.park.msu.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
>
> On Wed, Sep 21, 2005 at 11:42:32PM -0700, Andrew Morton wrote:
> > Wow, never seen that done before.  Does it actually work?  For keyboard,
> > serial console and /proc/sysrq-trigger?
> 
> Yes, all of this works for me.
> 
> There is another problem on Alpha with 2.6.14-rc kernels, much worse:
> slab.c:index_of() works _only_ when it's really inlined, because of
> __builtin_constant_p() check. It happens to work on other archs
> due to "always_inline" alchemy in compiler.h, but on Alpha we undo 
> the "inline" redefinitions as they heavily break our internal stuff.
> So the slab.c blows up very early on boot (at least when compiled
> with gcc3).

hm, you might need to do some special-casing around that function.

> I'd be happy if it is possible to stop global redefining of "inline"
> keywords and just use __attribute__((always_inline)) when needed.
> If not, I don't know how to fix that cleanly.

We did that because gcc 3.3 (iirc) was utterly buggered.  I forget what it
was doing exactly - generating out-of-line copies in various compilation
units, using more stack space as a result.  That workaround shrunk typical
x86 kernels by ~64k.

If recent gcc's have a -fdont-be-so-damn-stupid option we could use that.

