Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265820AbUFDPh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUFDPh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFDPhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:37:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:1260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265820AbUFDPgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:36:21 -0400
Date: Fri, 4 Jun 2004 08:36:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
In-Reply-To: <200406040826.15427.luto@myrealbox.com>
Message-ID: <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de>
 <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jun 2004, Andy Lutomirski wrote:
> 
> This is wrong on SELinux (and presumably with other LSMs). It also does
> unexpected things if you fail to exec a setuid executable.

Let's not do this at all.

Anything that changes subtle behaviour at suid-execute time is just wrong.  
Imagine an app that has been tested in normal use, and then has a subtle
bug when executed set-uid, simply because the address space layout
changes. Or something that mysteriously works when you're root, but not
when you're anything else. Ouch.

I think we should just look at the executable itself, not whether it is
suid. If the executable says it is "NX-approved", then it's NX-approved. 
End of story - just try to make sure that as many executables as possible 
get compiled with the newer compiler suite that enables it.

Add a tool to let people turn on/off the NX bit on an executable if it
turns out the executable can't work with it (let's say it was compiled and
tested on a CPU without NX support), and everybody should be happy. You 
can have a trivial script that turns on the NX bit on all the legacy apps 
too, and then if testing shows iot wasn't a good idea, you can turn it off 
again on a per-executable basis.

No?

		Linus
