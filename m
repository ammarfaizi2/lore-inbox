Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSJJL0V>; Thu, 10 Oct 2002 07:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263369AbSJJL0V>; Thu, 10 Oct 2002 07:26:21 -0400
Received: from holomorphy.com ([66.224.33.161]:21481 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261866AbSJJL0U>;
	Thu, 10 Oct 2002 07:26:20 -0400
Date: Thu, 10 Oct 2002 04:28:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@fenrus.demon.nl>, colpatch@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, LSE <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <20021010112844.GW12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjanv@fenrus.demon.nl>, colpatch@us.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, LSE <lse-tech@lists.sourceforge.net>,
	Andrew Morton <akpm@zip.com.au>, Martin Bligh <mjbligh@us.ibm.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <3DA4D3E4.6080401@us.ibm.com> <1034244381.3629.8.camel@localhost.localdomain> <1034248971.2044.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034248971.2044.118.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Matthew Dobson wrote:
>>> +asmlinkage long sys_mem_setbinding(pid_t pid, unsigned long memblks, 
>>> +				    unsigned int behavior)

On Thu, 2002-10-10 at 11:06, Arjan van de Ven wrote:
>> Do you really think exposing low level internals as memory layout / zone
>> split up to userspace is a good idea ? (and worth it given that the VM
>> already has a cpu locality preference?)

On Thu, Oct 10, 2002 at 12:22:51PM +0100, Alan Cox wrote:
> At least in the embedded world that level is a good idea. I'm not sure
> about the syscall interface. An "unsigned long" mask of blocks sounds
> like a good way to ensure a broken syscall in the future

Seconded wrt. memblk bitmask interface.

IMHO this level of topology exposure is not inappropriate. These kinds
of details are already exported (unidirectionally) by /proc/, if not
dmesg(1) and in my mind there is neither an aesthetic nor practical
barrier to referring to these machine features in userspace API's
in an advisory way (and absolutely not any kind of reliance). It's
simply another kind of request, and one which several high-performance
applications would like to make. I would also be interested in hearing
more of how embedded applications would make use of this, as my direct
experience in embedded systems is somewhat lacking.

Also, I've already privately replied with some of my stylistic concerns,
including things like the separability of the for_each_in_zonelist()
cleanup bundled into the patch and a typedef or so.


Bill
