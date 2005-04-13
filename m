Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVDMSmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDMSmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVDMSkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:40:04 -0400
Received: from colin2.muc.de ([193.149.48.15]:48656 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261190AbVDMSh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:37:26 -0400
Date: 13 Apr 2005 20:37:25 +0200
Date: Wed, 13 Apr 2005 20:37:25 +0200
From: Andi Kleen <ak@muc.de>
To: Ross Biro <ross.biro@gmail.com>
Cc: Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Message-ID: <20050413183725.GG50241@muc.de>
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de> <8783be66050412075218b2b0b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8783be66050412075218b2b0b0@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:52:55AM -0400, Ross Biro wrote:
> On Apr 10, 2005 9:29 AM, Andi Kleen <ak@muc.de> wrote:
> > 
> > 
> > The right way to do this would be to have sysfs knobs that allow
> > to change these bits, and then let a user space tool change
> > it depending on PCI-ID. If the issue is critical enough
> > that it happens very often then it should be added to kernel
> > pci quirks - but again be unconditional.
> 
> 
> Using user space knobs has advantages, but nothing can depend on just the 
> hardware configuration. The application the machine is being used for also 
> matters. Image you have one of the bad NICs and an IDE controller behind the 
> same bridge. Then you have to chose between silent data corruption and the 
> NIC locking up for up to a few minutes once in a while. The correct choice 
> depends on the application. 
> 
> For the way we use machines, we are better off with a compile time option 
> and no boot line override. That's clearly wrong for general use.

That is definitely wrong for general use. In fact the Linux kernel
has been moving away from the old "put weird workarounds into CONFIG"
for quite some time now. One big reason is that actually most 
users use binary kernels these days, but even for us who recompile
kernels regularly it is inconvenient to recompile kernels just for
such things.

If you want it compiled in for your use case I would recommend
that you add a local patch or add a patch for a compiled in kernel
command line in config (some non i386 archs have this already)

> 
> You're argument that no one can make sense of such options is totally off 
> base. Once you are having a problem, it's pretty easy to see if it's related 

I dont think it is in any way help to put suche highly obscure
things into Config. Near nobody can make any sense of it.

If you take a look at quirks.c and DMI options you will see we have quite a lot 
of workarounds for various hardware bug. Just imagine there were 
CONFIG options for all of this. It would be a big mess!

> to a wrong master abort mode setting. If you see data that is all 0xff's 
> somewhere it shouldn't be, for example on a hard drive sector (it usually 
> occurs in the file system meta data and not in the data itself) you need to 
> force master abort mode on. If you have a mis-behaving PCI device and 
> everytime it misbehaves, the saw target abort bit is set, then you need to 
> force master abort mode off. First line tech support people should be able 
> to tell users to use these settings.

Yeah, but that is impossible if it is a CONFIG - they would need
to expnain the users first how to recompile a kernel, which would
be totally wasted time because it can be set fine without any recompilation
if done properly.

> 
> I actually don't see any reason you would ever want master abort mode off, 
> other than you have buggy hardware. Unfortunately when you are working with 
> PC's you have to assume you always have buggy hardware. I don't have much 
> experience with other platforms, so I'll assume they are better (those of 
> you with experience, please do not disillusion me.)

Probably yes. 

What you could do is to put a experimental patch that forces this always
into -mm* for a few weeks and see if there are any bad reports.

-Andi
