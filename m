Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTD3Wy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTD3Wy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:54:58 -0400
Received: from aneto.able.es ([212.97.163.22]:17895 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262499AbTD3Wyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:54:54 -0400
Date: Thu, 1 May 2003 01:07:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: naive questions about thrashing
Message-ID: <20030430230701.GA7256@werewolf.able.es>
References: <3EB00FD2.5000008@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3EB00FD2.5000008@techsource.com>; from miller@techsource.com on Wed, Apr 30, 2003 at 20:02:58 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.30, Timothy Miller wrote:
> I am running kernel version 2.4.18-26.7.x under Red Hat 7.2.
> 
> I wrote a CPU-intensive program which attempts to use over 700 megs of 
> RAM on a 512-meg box, therefore it thrashes.
> 
> One thing I noticed was that 'top' reported that the kernel ("system") 
> was using 68% of the CPU.  (The offending process was getting about 9%.) 
>   How much CPU involvement is there in sending I/O requests to the drive 
> and waiting on an interrupt?  Maybe I don't understand what's going on, 
> but I would expect the CPU involvement in disk I/O to be practically 
> NIL, unless it's trying to be really smart about it.  Is it?  Or maybe 
> the kernel isn't using DMA... this is a Dell Precision 340.  I'm not 
> sure what drive is in it, but I would be surprised if it weren't using DMA.
> 

As I understand it, it is telling you that your programs spends 68% of
its time is kernel space, ie, waiting your pages to come from disk. It
does not mean that the CPU is doing anything, but it is locked by the
kernel.

If you can't afford to buy more memory, recode the thing. So much thrashing
looks like you access your data very randomly. Try to process the data
in a more sequential way, so you just fault after processing a big bunch
of data. With 700Mb of data and a 512Mb box, at least half of your data
fit in memory, so under an ideal sequential access you just would page
300Mb one time...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc1-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
