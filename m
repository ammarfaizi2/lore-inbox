Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWCOTrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWCOTrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 14:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWCOTrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 14:47:48 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:50320 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750771AbWCOTrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 14:47:47 -0500
In-Reply-To: <20060315193114.GA7465@in.ibm.com>
References: <20060315193114.GA7465@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <377D0492-8F52-4295-8D3B-A1ED8E24A13A@kernel.crashing.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Date: Wed, 15 Mar 2006 13:48:18 -0600
To: vgoyal@in.ibm.com
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 15, 2006, at 1:31 PM, Vivek Goyal wrote:

> Hi,
>
> Is there a reason why "start" and "end" field of "struct resource"  
> are of
> type unsigned long. My understanding is that "struct resource" can  
> be used
> to represent any system resource including physical memory. But  
> unsigned
> long is not suffcient to represent memory more than 4GB on PAE  
> systems.
>
> Currently /proc/iomem exports physical memory also apart from io  
> device
> memory. But on i386, it truncates any memory more than 4GB. This leads
> to problems for kexec/kdump.
>
> - Kexec reads /proc/iomem to determine the system memory layout and  
> prepares
>   a memory map based on that and passes it to the kernel being  
> kexeced. Given
>   the fact that memory more than 4GB has been truncated, new kernel  
> never
>   gets to see and use that memory.
>
> - Kdump also reads /proc/iomem to determine the physical memory  
> layout of
>   the system and encodes this informaiton in ELF headers. After a  
> crash
>   new kernel parses these ELF headers being used by previous kernel  
> and
>   vmcore is prepared accordingly. As memory more than 4GB has been  
> truncated,
>   kdump never sees that memory and never prepares ELF headers for  
> it. Hence
>   vmcore is truncated and limited to 4GB even if there is more  
> physical
>   memory in the system.
>
> One of the possible solutions to this problem is that expand the size
> of "start" and "end" to "unsigned long long". But whole of the PCI and
> driver code has been written assuming start and end to be unsigned  
> long
> and compiler starts throwing warnings.
>
> I am attaching a prototype patch which does minimal changes to make  
> memory
> more than 4GB appear in /proc/iomem. It does not take care of  
> modifying
> in tree drivers to supress warnings.
>
> Looking for your suggestion what's the best way to handle this  
> issue. If
> above approach seems reasonable then I can go ahead and do the changes
> for in tree drivers to handle the warnings.
>
> Thanks
> Vivek
> -

Your patch is insufficient.  You really need to audit all the users  
of "struct resource".  If you search the lkml archives you will see  
that Deepak Saxena, GregKH, and myself have taken stabs at this.  You  
should start with Greg's patch which I'm guessing is rather out of  
date now.

- kumar

