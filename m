Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWI1RMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWI1RMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWI1RMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:12:08 -0400
Received: from ns.suse.de ([195.135.220.2]:43937 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751861AbWI1RMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:12:06 -0400
From: Andi Kleen <ak@suse.de>
To: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [2.6.18-rc7-mm1] slow boot
Date: Thu, 28 Sep 2006 19:12:01 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, jbeulich@novell.com
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org> <451BFFA9.4030000@imap.cc>
In-Reply-To: <451BFFA9.4030000@imap.cc>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609281912.01858.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 19:00, Tilman Schmidt wrote:

missing context here, but ...

> On 24.09.2006 23:53, Andrew Morton wrote:
> > Do you have the time to go through the
> > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> > process?
> 
> Phew, it's done. And the winner is:
> 
> x86_64-mm-i386-stacktrace-unwinder.patch
> --------8<--------8<--------8<--------8<--------8<--------8<--------
> i386: Do stacktracer conversion too
> 
> Following x86-64 patches. Reuses code from them in fact.
> 
> Convert the standard backtracer to do all output using
> callbacks.   Use the x86-64 stack tracer implementation
> that uses these callbacks to implement the stacktrace interface.
> 
> This allows to use the new dwarf2 unwinder for stacktrace
> and get better backtraces.
> 
> Cc: mingo@elte.hu
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> -------->8-------->8-------->8-------->8-------->8-------->8--------
> 
> Backing out just this patch from 2.6.18-mm1 (and resolving conflicts
> manually the obvious way) gets the boot time back to normal (ie. as
> fast as 2.6.18 mainline) on my
> Linux gx110 2.6.18-mm1-noinitrd #2 PREEMPT Thu Sep 28 18:48:32 CEST 2006 i686 i686 i386 GNU/Linux
> machine.


Hmm, i assume you have lockdep on. The new backtracer is of course slower
than the old one and it will slow down lockdep which takes a lot of backtraces. 
But it shouldn't be a significant slowdown.

Can you perhaps boot with profile=1 and then send readprofile output after
boot?

-Andi
