Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263434AbVCKPuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbVCKPuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbVCKPuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:50:55 -0500
Received: from atropo.wseurope.com ([195.110.122.67]:52911 "EHLO
	atropo.wseurope.com") by vger.kernel.org with ESMTP id S263435AbVCKPuK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:50:10 -0500
From: Fabio Coatti <fabio.coatti@wseurope.com>
Organization: Wireless Solutions S.p.A.
To: Jens Axboe <axboe@suse.de>
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Date: Fri, 11 Mar 2005 16:50:06 +0100
User-Agent: KMail/1.8
Cc: Simone Piunno <simone.piunno@wseurope.com>, Baruch Even <baruch@ev-en.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111514.34949.simone.piunno@wseurope.com> <20050311151644.GJ28188@suse.de>
In-Reply-To: <20050311151644.GJ28188@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503111650.07336.fabio.coatti@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 16:16, venerdì 11 marzo 2005, Jens Axboe ha scritto:
> On Fri, Mar 11 2005, Simone Piunno wrote:
> > Alle 14:29, venerdì 11 marzo 2005, Baruch Even ha scritto:
> > > echo t > /proc/sysrq-trigger
> >
> > Before killing bonnie:
>
> I'm guessing your problem is that bonnie dirtied tons of data before you
> killed it, so it has to flush it out. If you run out of request entries,
> you will get to sleep uninterruptibly on those while the data is
> flushing. I don't see anything unexpected here, it is normal behaviour.

The real issue here is that under heavy I/O activity (bonnie is a good way to 
emphasize the concept), even caused by only one task, the system becomes 
quite unresponsive and "sluggish". The same can be seen under a gentoo 
"emerge --metadata", and slocate has the same effect.
The problem is not only related to desktop, but i.e. on a dual opteron il 
takes several seconds to have an "ls" output (on a nearly empty dir) or 
simply to log in using ssh.
It seems to me that I/O scheduler gives high priority to the running process 
and any other request is delayed to the point that the responsiveness of a 
desktop becomes poor (say, to open a "K" menu takes several seconds on a pIV 
2.8G HT).
In every case, we seen that the I/O bound processes are stuck in "D" state, 
the same stands for pdflush and kswapd.


-- 
Fabio Coatti              Wireless Solutions SpA - DADA group   
Services Manager        Europe HQ, via Castiglione 25 Bologna 
http://www.wseurope.com     Tel: +390512966811 Fax: +390512966800
