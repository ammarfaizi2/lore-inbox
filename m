Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTLOUhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTLOUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:37:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6084 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262109AbTLOUhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:37:06 -0500
Message-ID: <3FDE1B65.3020900@pobox.com>
Date: Mon, 15 Dec 2003 15:36:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDC9DC5.2070302@intel.com> <Pine.LNX.4.58.0312151023570.1488@home.osdl.org> <3FDE17B3.40009@intel.com>
In-Reply-To: <3FDE17B3.40009@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev wrote:
> Linus, FIXMAP helps, it is lighter then ioremap, but it still requires 
> page table walk. In addition, since several operations should be done 
> atomically, lock/unlock required as well. Can it be faster method, 
> without page table walk for each transaction? To what extent should one 
> concern about performance here?
> 
> As alternative between 1 page and 256M, I see also lazy allocation on 
> per-bus basis: when bus is first accessed, ioremap 1Mb for it. On real 
> system, it is no more then 3-4 buses. This way, we will end with several 
> 1MB mappings. Finer granularity do not looks feasible, since bus 
> scanning procedure tries to access all devices.


Well, two things to consider:
* probing is not a performance-intensive operation
* even with a system loaded down with many PCI Express devices, I doubt 
you will need more than 1-2MB mapped total, during runtime

So, one alternative could be to keep a cache of ioremap() regions -- 
smaller than 1MB in my opinion -- and update that as needed.

Anybody doing large numbers of PCI config register reads/writes in a hot 
path should be shot (or the h/w designers, depending on situation), and 
PCI Express doesn't change that ;-)

	Jeff



