Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWHHAmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWHHAmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHHAmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:42:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:55249 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932463AbWHHAmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:42:24 -0400
Message-ID: <44D7DDEF.6070907@vmware.com>
Date: Mon, 07 Aug 2006 17:42:23 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       Sahil Rihan <srihan@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <44D217A7.9020608@redhat.com> <44D24236.305@vmware.com> <20060805104507.GA4506@ucw.cz> <44D67109.6020605@vmware.com> <20060808001255.GQ2759@elf.ucw.cz>
In-Reply-To: <20060808001255.GQ2759@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Well, I guess we'd like VMI to be buildable in normal kernel build
> tools ... and at that point, open sourcing it should be _really_ easy.
>
> And we'd prefer legal decisions not to influence technical ones. Maybe
> we will decide to use binary interface after all, but seeing GPLed,
> easily-buildable interface, first, means we can look at both solutions
> and decide which one is better.

I don't think you're actually arguing for the VMI ROM to be built into 
the kernel.  But since this could be a valid interpretation of what you 
said, let me address that point so other readers of this thread don't 
misinterpret.

On a purely technical level, the VMI layer must not be part of the 
normal kernel build.  It must be distributed by the hypervisor to which 
it communicates.  This is what provides hypervisor independence and 
hardware compatibility, and why it can't be distributed with the 
kernel.  The kernel interfaces for VMI that are part of the kernel 
proper are already completely open sourced and GPL'd.  The piece in 
question is the hypervisor specific VMI layer, which we have not yet 
released an open source distribution of.

We do use standard tools for building it, for the most part - although 
some perl scripting and elf munging magic is part of the build.  
Finally, since it is a ROM, we have to use a post-build tool to convert 
the extracted object to a ROM image and fix up the checksum.  We don't 
have a problem including any of those tools in an open source 
distribution of the VMI ESX ROM once we finish sorting through the 
license issues.  We've already fixed most of the problems we had with 
entangled header files so that we can create a buildable tarball that 
requires only standard GNU compilers, elf tools, and perl to run.  I 
believe the only technical issue left is fixing the makefiles so that 
building it doesn't require our rather complicated make system.

Hopefully we can have all this resolved soon so that you can build and 
distribute your own ROM images, see how the code operates, and use the 
base design framework as a blueprint for porting to other hypervisor 
implementations, porting other operating systems, or just as a general 
experimental layer that could be used for debugging or performance 
instrumentation.

Zach
