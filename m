Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWDRG6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWDRG6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 02:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWDRG6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 02:58:24 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:54627 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932253AbWDRG6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 02:58:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dJPbW3t6xPNCfvF6yqd1GCrNucJLx6TBPHnc78OkIR11SlIiNv7iThiodhX8cMBfax80X22ISPEab+ZhthQXDGunPGx4j3/dPw2Q0Bg7P2PcBjUKyqe7jco/laGmdrwvONv2v4kEGGN69+11G4tEh6VtqzxKyq9vXw2TSlK9UBU=  ;
Message-ID: <44448A60.4040903@yahoo.com.au>
Date: Tue, 18 Apr 2006 16:42:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Christoph Lameter <clameter@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
References: <1145049535.1336.128.camel@localhost.localdomain> <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com> <20060417220238.GD3945@localhost.localdomain> <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

> Understood, but I'm going to start looking in the way Rusty and Arnd
> suggested with the vmalloc approach. This would allow for saving of
> memory and dynamic allocation of module memory making it more robust. And
> all this without that evil extra indirection!

Remember that this approach could effectively just move the indirection to
the TLB / page tables (well, I say "moves" because large kernel mappings
are effectively free compared with 4K mappings).

So be careful about coding up a large amount of work before unleashing it:
I doubt you'll be able to find a solution that doesn't involve tradeoffs
somewhere (but wohoo if you can).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
