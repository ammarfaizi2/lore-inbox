Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbSI3MLe>; Mon, 30 Sep 2002 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSI3MLe>; Mon, 30 Sep 2002 08:11:34 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:28904 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262035AbSI3MLe>; Mon, 30 Sep 2002 08:11:34 -0400
Message-Id: <200209301216.g8UCGj6g053616@d12relay01.de.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] break out task_struct from sched.h
To: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Date: Mon, 30 Sep 2002 14:17:40 +0200
References: <Pine.LNX.4.33.0209292137550.7800-100000@gans.physik3.uni-rostock.de>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:

> This patch separates struct task_struct from <linux/sched.h> to 
> a new header <linux/task_struct.h>, so that dereferencing 'current'
> doesn't require to #include <linux/sched.h> and all of the 138 files it 
> drags in.
>  
> This is a preparatory step (and currently part of) the patch to remove
> 614 superfluous #includes of <linux/sched.h> at
>   http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-16.patch.gz

I tried something similar before: I seperated out mm_struct from sched.h
so that mm.h does not have to include sched.h any more. At that time,
the results were poor, because most of the files that include mm.h but
not sched.h actually need 'current' or something else from sched.h
and I then had to include sched.h by hand in them.

With your work, it probably makes sense to look into this again.
Note that 241 of your 614 files that don't need sched.h still include
it through either linux/mm.h or linux/interrupt.h, so don't gain anything
there.

There are some other headers that are critical as well (e.g. 
pci.h->device.h->sched.h), but afaics mm.h and interrupt.h are the most
common ones.

