Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWJQMEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWJQMEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWJQMEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:04:24 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:60072 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750707AbWJQMEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:04:23 -0400
Message-ID: <4534C5F5.70600@aitel.hist.no>
Date: Tue, 17 Oct 2006 14:00:53 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: mfbaustx <mfbaustx@gmail.com>
CC: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: copy_from_user / copy_to_user with no swap space
References: <op.thi3x1mvnwjy9v@titan> <200610162128.45229.oliver@neukum.org> <op.thi48zvznwjy9v@titan>
In-Reply-To: <op.thi48zvznwjy9v@titan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mfbaustx wrote:
>>>> No. Your code may be only partially paged into RAM.
>>>> The same can happen for any mmaped data.
>
> That's what I thought I read.  But then my question is:  with 
> on-demand paging, is it possible to have two processes partially 
> paged?  Surely, it MUST be the case that any processes with 
> overlapping logical address spaces must be paged coherently.  So, 
> while on-demand "paging-in" allows for partial paging of a process, is 
> it the case that, on a context switch, the user-space PTE's are 
> completely erased (so that you get page-faults and can then on-demand 
> page them in...)?
You can surely have two or more processes partially paged.
Or some processes more or less paged out, while some are not.

The kernel never looses track of the address spaces, and knows very well
which block on the swapdevice maps to what address.  And of course
it knows what process the block belongs to too.

Several processes can all have their own address 4096 swapped out
at the same time, for example. Obviously to different blocks on the 
swapdisk.
There is no need for any special care when several processes are
swapped at the same time.

Demand paging happens when a process tries to use memory but the
memory isn't there.  The processor will then get an exception and
schedule read-in of the missing memory.  When the memory eventually gets
there, the process is allowed to continue.

Helge Hafting

