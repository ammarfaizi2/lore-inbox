Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVADLKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVADLKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVADLKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:10:40 -0500
Received: from colin2.muc.de ([193.149.48.15]:16398 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261156AbVADLJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:09:42 -0500
Date: 4 Jan 2005 12:09:40 +0100
Date: Tue, 4 Jan 2005 12:09:40 +0100
From: Andi Kleen <ak@muc.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colin@coesta.com, linux-kernel@vger.kernel.org
Subject: Re: Max CPUs on x86_64 under 2.6.x
Message-ID: <20050104110940.GA32022@muc.de>
References: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com> <m14qhyxc9h.fsf@muc.de> <20050104022034.GB2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104022034.GB2708@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 06:20:34PM -0800, William Lee Irwin III wrote:
> "Colin Coe" <colin@coesta.com> writes:
> >> Why is the number of CPUs on the x86_64 architecture only 8 but under i386
> >> it is 255?
> >> I've searched the list archives and Google but can't find an answer.
> 
> On Tue, Jan 04, 2005 at 01:34:50AM +0100, Andi Kleen wrote:
> > Post 2.6.10 x86-64 will support more CPUs. 2.6.10 actually does too,
> > but the Kconfig hadn't been changed then. Previously there was an
> > 8 CPU APIC driver limit, however it turned out later that it doesn't
> > apply to some Opteron machines.
> 
> Barring cpus with a different onboard interrupt controller from the
> xAPIC or the use of external interrupt controllers to assist with cpu
> addressing, 255 serves as an architectural limit for Opteron as well.

Yes, 255 is the limit, but not 8. Opteron can enable a special flat
mode that allows flat APIC addressing upto 255.   I assume the BIOS
will set that bit on machines with that many CPUs. 

I recently audited the flat APIC code and I think it should work without 
changes to 255 CPUs, but I wasn't able to test it so far.

However 2.6.10 supports clustered mode now anyways, so you could
probably use more CPUs given the right x86-64 IBM machine. I don't
know if that has been tested so far.

The change to extend NR_CPUs and the max number of nodes just went into 
Linus' tree, you would need a recent bk snapshot.

http://linux.bkbits.net:8080/linux-2.6/cset@41da1ff62QYI89HDgrcKwnBAz6wgQg?nav=index.html|ChangeSet@-1d

-Andi
