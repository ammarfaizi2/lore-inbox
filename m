Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWJFTxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWJFTxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJFTxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:53:32 -0400
Received: from kanga.kvack.org ([66.96.29.28]:39333 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932335AbWJFTxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:53:30 -0400
Date: Fri, 6 Oct 2006 15:53:19 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>, David Howells <dhowells@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061006195319.GA18665@kvack.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <20061006162054.GF14186@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006162054.GF14186@rhun.haifa.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 06:20:54PM +0200, Muli Ben-Yehuda wrote:
> On Fri, Oct 06, 2006 at 05:50:21PM +0200, Muli Ben-Yehuda wrote:
> 
> > > What happens if you boot with max_cpus=1?
> > 
> > Trying it now... woohoo, it boots all the way and stays up!
> 
> Ok, after verifying that maxcpus=1 causes the problematic changeset to
> boot, I also tried maxcpus=1 with the tip of the tree. I hit this NULL
> pointer dereference in profile_tick, with and without
> maxcpus=1. Disassembly says that get_irq_regs() is returning NULL,
> which may or may not be related to the genirq issue.

I ran into this as well and managed to bisect it to the following commit:

7d12e780e003f93433d49ce78cfedf4b4c52adc5 is first bad commit
commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Author: David Howells <dhowells@redhat.com>
Date:   Thu Oct 5 14:55:46 2006 +0100

    IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
...

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
