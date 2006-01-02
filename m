Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWABT0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWABT0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWABT03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:26:29 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:21485 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750975AbWABT03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:26:29 -0500
Date: Mon, 2 Jan 2006 20:26:13 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>, mingo@elte.hu,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102192613.GA9935@wohnheim.fh-wedel.de>
References: <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <1136227746.2936.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136227746.2936.46.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 January 2006 19:49:06 +0100, Arjan van de Ven wrote:
> 
> > I'd be reluctant to trust gcc-4 to do the right thing in all cases.  If the
> > compiler fails to inline functions in certain critical cases we'll suffer
> > some performance loss and the source of that performance loss will be
> > utterly obscure.
> 
> yet.. turning inline into a hint (which causes gcc to greatly bias
> towards inlining without making it absolute) was also opposed by either
> you or Linus. Forcing is ALSO wrong. For example it causes gcc to do
> inlining even for functions that use variable sized arrays ;(

I believe your example is a non-issue by Linus' terms.  AFAIR, he
always considered variable sized arrays a bug, when used for kernel
code.  Line of argument is something like this:

o If a variable-sized array has an unknown upper bound, the stack
  will explode.
o If the upper bound is well-known, using a fixed-size array works
  just as well.
o make checkstack is unable to interpret the function preamble in
  presence of alloca() or variable sized arrays.

The last point is from irc today, not from Linus.


Interestingly, Linus and Ingo/you are arguing similarly:

Linus: I don't want to allow sloppiness.  If you know the upper bound,
I force you to write it down explicitly by using a fixed-size array.

Ingo: I don't want to allow sloppiness.  Either the inline is required
and shall be written as always_inline, or it is not and should be
removed.

Disallowing sloppiness might be a good idea in both cases.  Along
those lines, "inline" is quite seductive to over-use by sloppy
developers.  "always_inline" or "in_this_rare_case_inline_makes_sense"
would at least force sloppy people to get second thoughts.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
