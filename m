Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUEaRfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUEaRfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUEaRe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 13:34:59 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54197 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264702AbUEaRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 13:34:56 -0400
Subject: Re: Linux 2.6.7-rc2
From: Albert Cahalan <albert@users.sf.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       petero2@telia.com, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405310948120.4573@ppc970.osdl.org>
References: <1086006023.8188.34.camel@cube>
	 <Pine.LNX.4.58.0405310948120.4573@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1086016346.8185.68.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 May 2004 11:12:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-31 at 12:53, Linus Torvalds wrote:
> On Mon, 31 May 2004, Albert Cahalan wrote:
> > 
> > This would be required because of the -Wno-strict-aliasing
> > option. For the 2.7.xx kernels, how about we start off by
> > replacing -Wno-strict-aliasing with -std=gnu99 ? It's been
> > 5 years since 1999. The "restrict" keyword is useful too.
> 
> No can do.
> 
> Aliasing in gcc is so broken (_purely_ type-based and no way to avoid it
> sanely in older versions) that it's not going to happen.
> 
> When we can depend on everybody having gcc-3.3+ something, and that one
> properly supports the "may_alias" attribute, we may change that.

By the time Linux 2.8.0 is out, gcc-3.3+ should be
a perfectly reasonable requirement.

In the mean time, adding may_alias as needed would be
a good idea.

If all this were behind CONFIG_BROKEN, it sure wouldn't
hurt even today. People might as well get started.
The compiler will keep being pessimistic and dumb until
the -Wno-strict-aliasing option is dropped.

> "restrict" is pretty much useless. It just weakens the already too-weak
> alias rules of standard gcc.

It's easiest to use on function parameters. This helps
the optimizer without being a mind-warping excercise.


