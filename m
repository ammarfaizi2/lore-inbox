Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUDGQlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbUDGQlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:41:11 -0400
Received: from waste.org ([209.173.204.2]:38121 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263734AbUDGQk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:40:58 -0400
Date: Wed, 7 Apr 2004 11:40:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       celinux-dev@tree.celinuxforum.org
Subject: Re: 2.6.5-rc1-tiny1 for small systems
Message-ID: <20040407164035.GT6248@waste.org>
References: <20040316222548.GD11010@waste.org> <200404070833.26197.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404070833.26197.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 08:33:25AM +0300, Denis Vlasenko wrote:
> On Wednesday 17 March 2004 00:25, Matt Mackall wrote:
> > This is the latest release of the -tiny kernel tree. The aim of this
> > tree is to collect patches that reduce kernel disk and memory
> > footprint as well as tools for working on small systems. Target users
> > are things like embedded systems, small or legacy desktop folks, and
> > handhelds.
> >
> > This release is primarily a resync with 2.6.5-rc1 and contains various
> > compile fixes and other cleanups.
> >
> > The patch can be found at:
> >
> >  http://selenic.com/tiny/2.6.5-rc1-tiny1.patch.bz2
> >  http://selenic.com/tiny/2.6.5-rc1-tiny1-broken-out.tar.bz2
> >
> > Webpage for your bookmarking pleasure:
> >
> >  http://selenic.com/tiny-about/
> 
> With attached .config, I get this:
>   CC      lib/div64.o
>   CC      lib/dump_stack.o
>   CC      lib/errno.o
>   CC      lib/extable.o
>   CC      lib/idr.o
>   CC      lib/inflate.o
> lib/inflate.c:138: syntax error before "void"
> make[1]: *** [lib/inflate.o] Error 1
> make: *** [lib] Error 2
> 
> lib/inflate.c:
> static u32 crc_32_tab[256];
> 
> static INIT void makecrc(void)
>        ^^^^
> {
>         unsigned i, j;
>         u32 c = 1;

Just changing that to __init should fix things. That got broken in a
recent patch reordering and doesn't get compiled with the CRC
shrinking option on.

> Originally I wanted to have CONFIG_MEASURE_INLINES=y,
> but it died even earlier, looks like my gcc does not like
> the fact that there is way too many warnings for
> eisa-bus.c.

Hmm, that's interesting. The measure inlines stuff works by generating
warnings, but I have yet to see recent GCC quit after too many warnings.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
