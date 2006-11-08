Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWKHSkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWKHSkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWKHSkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:40:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161431AbWKHSkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:40:21 -0500
Date: Wed, 8 Nov 2006 10:36:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>, Jeff Chua <jeff.chua.linux@gmail.com>
cc: Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       Aaron Durbin <adurbin@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
In-Reply-To: <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0611081010120.3667@g5.osdl.org>
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
 <20061107171143.GU27140@parisc-linux.org> <200611080839.46670.ak@suse.de>
 <20061108122237.GF27140@parisc-linux.org> <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
 <20061108172650.GC4729@stusta.de> <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
 <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2006, Linus Torvalds wrote:
> 
> I'm going to revert that totally bogus commit that added that broken 
> "pci_mmcfg_insert_resources()" function.

Pushed out. Jeff, can you verify that current git does the right thing.

Andi - I also ported the x86 io-apic cleanup and fixes to x86-64. I'll 
push those out too once I've verified them on the machines I have access 
to.

I'm still not 100% happy about the io-apic thing (for example, I was 
thinking that maybe we should just automatically choose the order of 
writes in apic_write_entry() by just checking whether "mask" was set or 
not), but the code really is cleaner, and on x86 it was verified to fix 
some things.

Keeping in sync is still better than having two different approaches, one 
of which was confirmed broken. And the i386 code is definitely more tested 
over the years than the x86-64 code could ever have hoped to be, so going 
back to the original ordering makes sense.

		Linus
