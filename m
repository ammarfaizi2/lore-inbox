Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUD2DUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUD2DUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUD2DUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:20:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:38090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263059AbUD2DT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:19:59 -0400
Date: Wed, 28 Apr 2004 20:19:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Singer <elf@buici.com>
Cc: riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428201924.719dfb68.akpm@osdl.org>
In-Reply-To: <20040429031059.GA26060@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org>
	<Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
	<20040428185720.07a3da4d.akpm@osdl.org>
	<20040429022944.GA24000@buici.com>
	<20040428193541.1e2cf489.akpm@osdl.org>
	<20040429031059.GA26060@buici.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>
> > That's what people have been asking for.  What are you suggesting should
> > happen instead?
> 
> I'm thinking that the problem is that the page cache is greedier that
> most people expect.  For example, if I could hold the page cache to be
> under a specific size, then I could do some performance measurements.
> E.g, compile kernel with a 768K page cache, 512K, 256K and 128K.  On a
> machine with loads of RAM, where's the optimal page cache size?

Nope, there's no point in leaving free memory floating about when the
kernel can and will reclaim clean pagecache on demand.

What you discuss above is just an implementation detail.  Forget it.  What
are the requirements?  Thus far I've seen

a) updatedb causes cache reclaim

b) updatedb causes swapout

c) prefer that openoffice/mozilla not get paged out when there's heavy
   pagecache demand.

For a) we don't really have a solution.  Some have been proposed but they
could have serious downsides.

For b) and c) we can tune the pageout-vs-cache reclaim tendency with
/proc/sys/vm/swappiness, only nobody seems to know that.

What else is there?
