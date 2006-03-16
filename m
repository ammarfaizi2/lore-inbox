Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCPOrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCPOrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 09:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWCPOrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 09:47:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7137 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751189AbWCPOrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 09:47:01 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Kumar Gala <galak@kernel.crashing.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<20060315205306.GC25361@kvack.org>
	<46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
	<20060315211335.GD25361@kvack.org>
	<m1y7zbe6rn.fsf@ebiederm.dsl.xmission.com>
	<20060315212841.GE25361@kvack.org>
	<m13bhje5d1.fsf@ebiederm.dsl.xmission.com>
	<20060315220727.GF25361@kvack.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Mar 2006 07:45:23 -0700
In-Reply-To: <20060315220727.GF25361@kvack.org> (Benjamin LaHaise's message
 of "Wed, 15 Mar 2006 17:07:27 -0500")
Message-ID: <m1r752bg8s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Wed, Mar 15, 2006 at 02:59:54PM -0700, Eric W. Biederman wrote:
>> Actually now that I think back there are machines with < 4GiB of ram
>> with 64bit pci BAR values.  It is more common to have 32bit values BAR
>> values and > 4GiB of ram.
>
> Such machines on x86 would have to be compiled with PAE.  Ditto any other 
> architecture, as you *have* to be able to represent those physical addresses, 
> which requires having page tables that can map them, which requires whatever 
> PAE is on the platform.

It depends on who the user is.  In the case that inspired this thread
user space can profit from the information even when the kernel can't.
In addition it appears kernel code quality can benefit as well.

>> Nor do I think struct resource is nearly as important when being
>> efficient, as dma_addr_t.  struct resource is only used during
>> driver setup which is a very rare event.  A few extra instructions
>> there likely will get lost in the noise and most of the will probably
>> be removed because they are in an __init section anyway.
>
> Bloat for no good reason is a bad habit to get into.

I agree bloat for no good reason is a bad habit to get into.
Premature optimization is a worse habit to get into, as is making
problems unnecessarily complex.  Until working patches are produced,
and the impact can be assessed it is to soon to seriously worry about
something that back of the napkin calculations indicate suggest
will have no measurable impact.

Eric

