Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283385AbRK2Skp>; Thu, 29 Nov 2001 13:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRK2Skj>; Thu, 29 Nov 2001 13:40:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3600 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283389AbRK2SkT>;
	Thu, 29 Nov 2001 13:40:19 -0500
Date: Thu, 29 Nov 2001 19:39:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Dirk Pritsch <dirk@enterprise.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.5.1-pre3 in ide-scsi module
Message-ID: <20011129193956.S10601@suse.de>
In-Reply-To: <20011129191938.A1402@Enterprise.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129191938.A1402@Enterprise.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Dirk Pritsch wrote:
> Hi,
> 
> just tried the new 2.5.1-pre3 and got the following oops when trying to
> burn a cd (ide-cd/rw with ide-scsi emulation).
> 
> I Hope this is some useful information.
> 
> 
> ____
> ksymoops 2.4.3 on i586 2.5.1-pre3.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.5.1-pre3/ (default)
>      -m /boot/System.map-2.5.1-pre3 (default)
> 
> Warning: You did not tell me where to find
> symbol information.  I will
> assume that the log matches the kernel and
> modules that are running
> right now and I'll use the default options
> above for symbol resolution.
> If the current kernel and/or modules do not
> match the log, you can get
> more accurate output by telling me the kernel
> version and where to find
> map, modules, ksyms etc.  ksymoops -h explains
> the options.
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000038
> c01af582
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[idescsi_queue+1158/1396]    Not tainted

Hmm, I bet the problem is not really bio but the fact that someone is
still sending down a scatterlist with ->address set instead of
->page/offset.

Let me hack a quick fix up for you to test... 2 minutes.

-- 
Jens Axboe

