Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319194AbSHNEUp>; Wed, 14 Aug 2002 00:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSHNEUp>; Wed, 14 Aug 2002 00:20:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6162 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319194AbSHNEUo>; Wed, 14 Aug 2002 00:20:44 -0400
Date: Tue, 13 Aug 2002 21:26:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
In-Reply-To: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Aug 2002, Alexander Viro wrote:
> 
> 
> On Wed, 14 Aug 2002, Benjamin LaHaise wrote:
> 
> > On Tue, Aug 13, 2002 at 09:11:55PM -0700, Andrew Morton wrote:
> > > It requires root.
> > 
> > Still, unlike kernel code that can be rate limited, this call cannot.  
> > Besides, isn't adding yet another syscall that's equivalent to write(2) 
> > a reason to take this patch and burn it along with the vomit its caused?
> 
> I have a better suggestion.  How about we make write(2) on /dev/console to
> act as printk()?  IOW, how about making _all_ writes to console show up in
> dmesg?
> 
> Then we don't need anything special to do logging _and_ we get output
> of init scripts captured.  For free.  dmesg(8) would pick that up, klogd(8)
> will work as is, etc.
> 
> Linus?

Well, apart from the fact that you get into an endless loop with klogd, 
who wants to spew the kernel messages back to the console under some 
circumstances..

That said, I like the notion. I've always hated the fact that all the 
boot-time messages get lost, simply because syslogd hadn't started, and 
as a result things like fsck ran without any sign afterwards. The kernel 
log approach saves it all in one place.

But /dev/console just sounds potentially _too_ noisy.

		Linus

