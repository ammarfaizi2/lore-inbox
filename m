Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUCVNOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 08:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUCVNOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 08:14:08 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:30634 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261961AbUCVNOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 08:14:06 -0500
Message-ID: <405EE706.2030004@mellanox.co.il>
Date: Mon, 22 Mar 2004 15:15:50 +0200
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com> <52u10i2lx6.fsf@topspin.com>	<405DCDA1.3080008@colorfullife.com> <52ptb62hdt.fsf@topspin.com>
In-Reply-To: <52ptb62hdt.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>I don't think copying all the registered memory on fork() is feasible,
>because it's going to kill performance (especially since exec() is
>likely to immediately follow the fork() in the child).  Also, there
>may not be enough memory around to copy everything.
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
the address space of the child does not inherit the range of the moddle 
pages. ???
Eli
