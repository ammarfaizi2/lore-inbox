Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWBXR1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWBXR1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWBXR1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:27:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932395AbWBXR1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:27:11 -0500
Date: Fri, 24 Feb 2006 09:26:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Rene Herman <rene.herman@keyaccess.nl>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0602240925170.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
 <1140707358.4672.67.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de>
 <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
 <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
 <43FE1764.6000300@keyaccess.nl> <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
 <43FE4B00.8080205@keyaccess.nl> <m1r75s3kfi.fsf@ebiederm.dsl.xmission.com>
 <43FF26A8.9070600@keyaccess.nl> <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Feb 2006, Eric W. Biederman wrote:
>
> > To my handwaving ears end of the address space sounds very good though. Is there
> > currently any pressure on VMALLOC_RESERVE (128M)? Teaching the linker appears to
> > be a matter of changing __KERNEL_START. That leaves actually mapping ourselves
> > there, and... more invasiveness?
> 
> __pa stops working on kernel addresses.

That's not the issue.

The real issue is the _physical_ address. Nothing else matters.

If the TLB splitting on the fixed MTRRs is an issue, it depends entirely 
on what physical address the kernel resides in, and the virtual address is 
totally inconsequential.

So playing games with virtual mapping has absolutely no upsides, and it 
definitely has downsides.

		Linus
