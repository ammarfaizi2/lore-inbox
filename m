Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWEPGrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWEPGrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 02:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWEPGrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 02:47:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17837 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751544AbWEPGrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 02:47:32 -0400
Date: Tue, 16 May 2006 08:47:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Gerd Hoffmann <kraxel@suse.de>, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060516064723.GA14121@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147759423.5492.102.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> AFAICT we'll pay one extra TLB entry for this patch.  Zach had a patch 
> which left the vsyscall page at the top of memory (minus hole for 
> hypervisor) and patched the ELF header at boot.

i'd suggest the solution from exec-shield (which has been there for a 
long time), which also randomizes the vsyscall vma. Exploits are already 
starting to use the vsyscall page (with predictable addresses) to 
circumvent randomization, it provides 'interesting' instructions to act 
as a syscall-functionality building block. Moving that address to 
another predictable place solves the virtualization problem, but doesnt 
solve the address-space randomization problem.

	Ingo
