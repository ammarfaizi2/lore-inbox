Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWAZE2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWAZE2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZE2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:28:50 -0500
Received: from colin.muc.de ([193.149.48.1]:26638 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750734AbWAZE2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:28:49 -0500
Date: 26 Jan 2006 05:28:48 +0100
Date: Thu, 26 Jan 2006 05:28:48 +0100
From: Andi Kleen <ak@muc.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug
Message-ID: <20060126042848.GB88680@muc.de>
References: <20060125120253.A30999@unix-os.sc.intel.com> <4496.1138242917@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4496.1138242917@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is nasty.  init() calls do_basic_setup() which calls
> do_initcalls().  init is normal text.  do_basic_setup and do_initcalls
> are .init.text.  gcc has inlined do_basic_setup and do_initcalls into
> init, even though they have different section attributes.  Naughty gcc.
> 
> This was using GCC: (GNU) 4.0.2 20050901 (prerelease) (SUSE Linux).
> Log a gcc bug.  Not a good omen for the idea of letting gcc decide when
> to inline!

Someone should file a bug in the gcc bugzilla then I guess.
Can you do that or should I?

> 
> Looking at the C code for do_initcalls(), the reference is obviously to
> initcall_debug.  I am puzzled about why the objdump lists
> .init.data+0x15b when initcall_debug is really at .init.data+0x164.

Ah thanks - ok i mislooked then. Anyways, it's not a bug.
 
> BTW, does anybody know why init() is not defined as __init?

Because it would crash then after returning from free_initmem.

-Andi
