Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTJYTSA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTJYTSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:18:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262770AbTJYTR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:17:59 -0400
Message-ID: <3F9ACC58.5010707@pobox.com>
Date: Sat, 25 Oct 2003 15:17:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Quite frankly, I'd much rather see a low-level graphics driver that does
> _two_ things, and those things only:
> 
>  - basic hardware enumeration and setup (and no, "basic setup" does not
>    mean "mode switching": it literally means things like doing the 
>    pci_enable_device() stuff.
> 
>  - serialization and arbitrary command queuing from a _trusted_ party (ie
>    it could take command lists from the X server, but not from untrusted
>    clients). This part basically boils down to "DMA and interrupts". This 
>    is the part that allows others to wait for command completion, "enough 
>    space in the ring buffers" etc. But it does _not_ know or care what the 
>    commands are.

Thank you for saying it.  This is what I have been preaching (quietly) 
for years -- command submission and synchronization (and thus, DMA/irq 
handling) needs to be in the kernel.  Everything else can be in 
userspace (excluding hardware enable/enumerate, of course).

Graphics processors are growing more general, too -- moving towards 
generic vector/data processing engines.  I bet you'll see an optimal 
model emerge where you have some sort of "JIT" for GPU microcode in 
userspace.  Multiple apps pipeline X/GL/hardware commands into the JIT, 
which in turn pipelines data and microcode commands to the GPU kernel 
driver.

	Jeff



