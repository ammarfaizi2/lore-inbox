Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUHLVmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUHLVmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268806AbUHLVjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:39:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:61141 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268817AbUHLVdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:33:16 -0400
Subject: Re: x86 - Realmode BIOS and Code calling module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakub Vana <gugux@centrum.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812133854Z2097966-29039+40063@mail.centrum.cz>
References: <20040812133854Z2097966-29039+40063@mail.centrum.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092342654.22362.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 21:30:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 14:38, Jakub Vana wrote:
> > Why is this better than LRMI in user mode.
> 
> I was now looking on LRMI. It must be a nice code, but It is still only
>  V86 emulation. I have listen that some BIOSes use something called 
> Unreal mode, that is realmode with segment registers used like in 
> protected mode. There is only one way, how to set this segregs - 
> switch to prot. mode, but if the BIOS try to switch when is running 
> in V86 CPU generates #GP (Global Protection fault). Not if it is 
> running in real Real Mode.

I've yet to meet a video bios that does this. I don't think the X folks
have either, but you could run it past Egbert to make sure. The 
"unreal" mode is normally only in existance during early boot.
> 
> > To do BIOS calls safely
> > you need to be very careful about things like PCI locking, I/O 
> > emulation and the ROM scribbling 
> 
> I'm not sure abou this, but I think there is not problem in calling 
> BIOS, here is problem in BIOS handling with this features and so 
> It's the problem of programmer that calls the BIOS to safely work
> and synchronize his hardware in kernel with BIOS. Other hardware 
> (that is not pawn by BIOS) can't make problems.

One example is PCI configuration accesses which must be co-ordinated
with the kernel, and through the kernel PCI interfaces. 

