Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263367AbVCKPRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbVCKPRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVCKPRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:17:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54726 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263367AbVCKPRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:17:04 -0500
Date: Fri, 11 Mar 2005 16:16:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Simone Piunno <simone.piunno@wseurope.com>
Cc: Baruch Even <baruch@ev-en.org>, Fabio Coatti <fabio.coatti@wseurope.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Message-ID: <20050311151644.GJ28188@suse.de>
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111420.52890.fabio.coatti@wseurope.com> <42319D2D.7060402@ev-en.org> <200503111514.34949.simone.piunno@wseurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503111514.34949.simone.piunno@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11 2005, Simone Piunno wrote:
> Alle 14:29, venerdì 11 marzo 2005, Baruch Even ha scritto:
> 
> > echo t > /proc/sysrq-trigger
> 
> Before killing bonnie:

I'm guessing your problem is that bonnie dirtied tons of data before you
killed it, so it has to flush it out. If you run out of request entries,
you will get to sleep uninterruptibly on those while the data is
flushing. I don't see anything unexpected here, it is normal behaviour.

> bonnie++      D ffff81010383f820     0  2042   2016
> (NOTLB)
> ffff8100f51d7248 0000000000000082 000000010000007d 000000000003bd42 
> ffff8101ffeee1f0 ffff8101ff538a60 ffff8101ff538cd8 0000000000000292 
> 0000000000000292 0000000000000282 
> Call Trace:<ffffffff804a0b11>{io_schedule+49} 
> <ffffffff80365a8e>{get_request_wait+174} 
> <ffffffff801459d0>{autoremove_wake_function+0} 
> <ffffffff801459d0>{autoremove_wake_function+0} 
> <ffffffff8036697c>{__make_request+812} 

This is what is happening here, after you kill it.

-- 
Jens Axboe

