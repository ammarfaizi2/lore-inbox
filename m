Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTKUIfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbTKUIfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:35:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:48067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264332AbTKUIfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:35:09 -0500
Date: Fri, 21 Nov 2003 00:40:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: iwamoto@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT leaks memory on linux-2.6.0-test9
Message-Id: <20031121004054.0d688bff.akpm@osdl.org>
In-Reply-To: <200311210324.35127.gene.heskett@verizon.net>
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp>
	<20031121073411.665A27007C@sv1.valinux.co.jp>
	<20031120235530.3d09882f.akpm@osdl.org>
	<200311210324.35127.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> On Friday 21 November 2003 02:55, Andrew Morton wrote:
> >IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
> >> It'll take a while to leak a noticable amount of memory. So I
> >> reduced the amount of memory using a boot option.
> >
> >Well I'll be darned.  I took a new version of fsstress and it
> > happens here too.  We're leaking anonymous memory.  -mm doesn't do
> > any better, either.
> 
> Running 2.6.0-test9-mm4, default as scheduler
> 
> That triggerd me to go look at ksysguard, and I've got 70 megs out in 
> swap in less than 24 hours uptime with my normal loading.  Usually it 
> takes me a couple of weeks to get that much as I've half a gig of 
> main memory.

That's good.  The kernel has given you 70 megs more memory.

>  Its also showing about 95 megs free.

free memory isn't really relevant.  If there's plenty of `buffers' and
pagecache around then it's mostly reclaimable.

>  Would this leak 
> show up there (ksysguard), and if so, in what section?

I don't know.

> T'would be nice if xosview were to be made operable, but this kernel 
> breaks it.  I used to keep it running in the corner of one of my 
> screens.

I had a patch for that.  Maybe it got merged.  You should hunt down the
upstream source and try it out.

For diagnosing this sort of thing it is best to learn to read the /proc
files.

