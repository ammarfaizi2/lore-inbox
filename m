Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUKVAOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUKVAOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKVAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:14:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:17088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbUKVANh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:13:37 -0500
Date: Sun, 21 Nov 2004 16:12:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: hch@infradead.org, torvalds@osdl.org, jongk@linux-m68k.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
Message-Id: <20041121161244.1a5ff193.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
	<20041101142245.GA28253@infradead.org>
	<20041116084341.GA24484@infradead.org>
	<20041116231248.5f61e489.akpm@osdl.org>
	<Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, 16 Nov 2004, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > > > There's tons of leaks in the hplcance probing code, and it doesn't release
> > >  > he memory region on removal either.
> > >  > 
> > >  > Untested patch to fix those issues below:
> > > 
> > >  ping.
> > 
> > The fix needs a fix:
> 
> Indeed.
> 
> And you should remove the definitions of dio_resource_{start,len}(), as they're
> already defined in linux/dio.h.
> 

But differently.   Christoph had:

+#define dio_resource_len(d) \
+       ((d)->resource.end - (d)->resource.start)

but dio.h has:

#define dio_resource_len(d)   ((d)->resource.end-(z)->resource.start+1)


Which is correct?
