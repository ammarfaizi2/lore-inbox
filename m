Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUHMXOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUHMXOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUHMXOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:14:46 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53978 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267708AbUHMXMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:12:13 -0400
Subject: Re: Preallocation of memory in 2.4 kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chandrasekhar nagaraj <chandrasekhar_n@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY17-F222koAUaQMni0003849e@hotmail.com>
References: <BAY17-F222koAUaQMni0003849e@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092434989.25002.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:09:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 19:11, chandrasekhar nagaraj wrote:
> We felt that we could preallocate some 64K of memory pool(before the IO 
> starts) and then when this kind of small memory request comes (note that 
> this request size is variable) , we would use this memory pool instead of 
> using the kmalloc.
> Is there any mechanism in 2.4 kernels to achieve this task.?

Yes - use kmalloc or multiple kmallocs before the I/O starts (eg
allocate in the driver startup). 2.6.x has a nice structure for doing
this and helpers but for the general case drivers just preallocate
buffers to be sure they can make progress. It's normally the most
efficient solution anyway.

