Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTJ0PQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJ0PQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:16:05 -0500
Received: from msgdirector3.onetel.net.uk ([212.67.96.159]:42317 "EHLO
	msgdirector3.onetel.net.uk") by vger.kernel.org with ESMTP
	id S263267AbTJ0PPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:15:52 -0500
Message-ID: <3F9D3643.9030400@tungstengraphics.com>
Date: Mon, 27 Oct 2003 15:14:11 +0000
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Egbert Eich <eich@xfree86.org>,
       Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com>
In-Reply-To: <3F9ACC58.5010707@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
> 
>> Quite frankly, I'd much rather see a low-level graphics driver that does
>> _two_ things, and those things only:
>>
>>  - basic hardware enumeration and setup (and no, "basic setup" does not
>>    mean "mode switching": it literally means things like doing the    
>> pci_enable_device() stuff.
>>
>>  - serialization and arbitrary command queuing from a _trusted_ party (ie
>>    it could take command lists from the X server, but not from untrusted
>>    clients). This part basically boils down to "DMA and interrupts". 
>> This    is the part that allows others to wait for command completion, 
>> "enough    space in the ring buffers" etc. But it does _not_ know or 
>> care what the    commands are.
> 
> 
> Thank you for saying it.  This is what I have been preaching (quietly) 
> for years -- command submission and synchronization (and thus, DMA/irq 
> handling) needs to be in the kernel.  Everything else can be in 
> userspace (excluding hardware enable/enumerate, of course).

To enable secure direct rendering on current hardware (ie without secure 
command submission mechanisms), you need command valididation somewhere.  This 
could be a layer on top of the minimal dma engine Linus describes.

> Graphics processors are growing more general, too -- moving towards 
> generic vector/data processing engines.  I bet you'll see an optimal 
> model emerge where you have some sort of "JIT" for GPU microcode in 
> userspace.  

You mean like the programmable fragment and vertex hardware that has been in 
use for a couple of years now?

Keith

