Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUCVPU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUCVPU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:20:59 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:58844 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262043AbUCVPU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:20:56 -0500
Message-ID: <405F04B5.2090609@mellanox.co.il>
Date: Mon, 22 Mar 2004 17:22:29 +0200
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com> <52u10i2lx6.fsf@topspin.com>	<405DCDA1.3080008@colorfullife.com> <52ptb62hdt.fsf@topspin.com>
In-Reply-To: <52ptb62hdt.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

> I don't think copying all the registered memory on fork() is feasible,
> because it's going to kill performance (especially since exec() is
> likely to immediately follow the fork() in the child).  Also, there
> may not be enough memory around to copy everything.
>
>  
>
Suppose a new vma flag is introduced, VM_NOCOW and an API to apply this 
flag on a range of addreses, splitting or unifying vmas as necessary. A 
driver which registers memory with hardware would call this function. 
When fork takes place, the ptes of the parent belonging to such vmas 
will not be changed to read only thus they will not undergo COW. The 
kernel will copy the first and last pages of theses vmas to the child. 
All the pages in between will be marked read only and will undergo COW 
when written to. One problem would be that that child can read pages of 
the parent after the parent modifies them but that could be avoided if 
the address space of the child does not inherit the range of the middle 
pages. ???
Eli
