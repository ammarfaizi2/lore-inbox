Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311090AbSCHUdx>; Fri, 8 Mar 2002 15:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311096AbSCHUdZ>; Fri, 8 Mar 2002 15:33:25 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:36846
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S311092AbSCHUcF>; Fri, 8 Mar 2002 15:32:05 -0500
Date: Fri, 8 Mar 2002 12:31:57 -0800
From: Danek Duvall <duvall@emufarm.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308203157.GA457@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308195939.A6295@devcon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 07:59:39PM +0100, Andreas Ferber wrote:

> Danek, can you please try changing the second argument to set_user()
> into 0, ie.
> 
>         /* Become root */
>         set_user(0, 0);

This works.  I initially didn't think it would, despite tracing the
problem correctly, because it didn't explain to me why mozilla would be
showing the problem.  As it turns out, though, mozilla does try to load
the ipv6 module, so that's why it demonstrates the problem.  Also, it
turns out that the problem with xmms goes away if I quit the first
invocation and start up a new one (the second one doesn't have to load
any modules), but mozilla keeps on showing the problem because it never
successfully loads the ipv6 module.

So it also turns out that either by changing that argument to 0 or just
reverting that hunk of the patch, xmms starts skipping whenever mozilla
loads a page, even a really simple one.  Disk activity and other network
activity don't seem to cause the skipping, and the skipping disappears
when I go back to an unaltered ac kernel, so there seems to be something
wrong with set_user(0, 0) as well, just a different problem.

Danek
