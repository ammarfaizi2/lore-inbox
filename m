Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161394AbWHDULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWHDULh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWHDULh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:11:37 -0400
Received: from gw.goop.org ([64.81.55.164]:10184 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161394AbWHDULg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:11:36 -0400
Message-ID: <44D3A9F3.2000000@goop.org>
Date: Fri, 04 Aug 2006 13:11:31 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Arjan van de Ven <arjan@linux.intel.com>,
       Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>   <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>   <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>   <1154667875.11382.37.camel@localhost.localdomain>   <20060803225357.e9ab5de1.akpm@osdl.org>   <1154675100.11382.47.camel@localhost.localdomain>   <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>  <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com>  <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz> <44D39F73.8000803@linux.intel.com> <Pine.LNX.4.63.0608041239430.18862@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0608041239430.18862@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> so if I understand this correctly we are saying that a kernel compiled 
> to run on hypervisor A would need to be recompiled to run on 
> hypervisor B, and recompiled again to run on hypervisor C, etc
>
> where A could be bare hardware, B could be Xen 2, C could be Xen 3, D 
> could be vmware, E could be vanilla Linux, etc.

Yes, but you can compile one kernel for any set of hypervisors, so if 
you want both Xen and VMI, then compile both in.  (You always get bare 
hardware support.)

> this sounds like something that the distros would not support, they 
> would pick their one hypervisor to support and leave out the others. 
> the big problem with this is that the preferred hypervisor will change 
> over time and people will be left with incompatable choices (or having 
> to compile their own kernels, including having to recompile older 
> kernels to support newer hypervisors)

Why?  That's like saying that distros will only bother to compile in one 
scsi driver.

The hypervisor driver is tricker than a normal kernel device driver, 
because in general it needs to be present from very early in boot, which 
precludes it from being a normal module.  There's hope that we'll be 
able to support hypervisor drivers as boot-time grub/multiboot modules, 
so you'll be able to compile up a new hypervisor driver for a particular 
kernel and use it without recompiling the whole thing.


    J
