Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUH1Fnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUH1Fnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUH1Fnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:43:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:48568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268185AbUH1FmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:42:19 -0400
Date: Fri, 27 Aug 2004 22:39:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: paulus@samba.org, ak@muc.de, davem@davemloft.net, ak@suse.de,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040827223954.7d021aac.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
	<Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	<20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040828010253.GA50329@muc.de>
	<20040827183940.33b38bc2.akpm@osdl.org>
	<16687.59671.869708.795999@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
	<20040827204241.25da512b.akpm@osdl.org>
	<Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Fri, 27 Aug 2004, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@sgi.com> wrote:
> > >
> > >  So I think the move to atomic for rss acceptable?
> >
> > Short-term, yes.  Longer term (within 12 months), no - 50-bit addresses on
> > power5 will cause it to overflow.
> 
> I would expect the page size to rise as well. On IA64 we already have
> 16KB-64KB pages corresponding to 256TB - 1PB. Having to manage a couple of
> billion pages could be a significant performance impact. Better increase
> the page size.

I don't know if that's an option on the power architecture.

And we need larger atomic types _anyway_ for page->_count.  An unprivileged
app can mmap the same page 4G times and can then munmap it once.  Do it on
purpose and it's a security hole.  Due it by accident and it's a crash.

> I still would also like to see atomic64_t. I think there was a patch
> posted to linux-ia64 a couple of months back introducing atomic64_t but it
> was rejected since it would not be supportable on other arches.

atomic64_t already appears to be implemented on alpha, ia64, mips, s390 and
sparc64.

As I said - for both these applications we need a new type which is
atomic64_t on 64-bit and atomic_t on 32-bit.
