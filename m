Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbVIVJFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbVIVJFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbVIVJFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:05:05 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:18579 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1030228AbVIVJFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:05:04 -0400
Date: Thu, 22 Sep 2005 13:04:49 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Kernel panic during SysRq-b on Alpha
Message-ID: <20050922130449.A29503@jurassic.park.msu.ru>
References: <43315BEB.3010909@ens-lyon.org> <20050922101259.A29179@jurassic.park.msu.ru> <20050921234232.1034cc02.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050921234232.1034cc02.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 21, 2005 at 11:42:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 11:42:32PM -0700, Andrew Morton wrote:
> Wow, never seen that done before.  Does it actually work?  For keyboard,
> serial console and /proc/sysrq-trigger?

Yes, all of this works for me.

There is another problem on Alpha with 2.6.14-rc kernels, much worse:
slab.c:index_of() works _only_ when it's really inlined, because of
__builtin_constant_p() check. It happens to work on other archs
due to "always_inline" alchemy in compiler.h, but on Alpha we undo 
the "inline" redefinitions as they heavily break our internal stuff.
So the slab.c blows up very early on boot (at least when compiled
with gcc3).

I'd be happy if it is possible to stop global redefining of "inline"
keywords and just use __attribute__((always_inline)) when needed.
If not, I don't know how to fix that cleanly.

Richard?

Ivan.
