Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135364AbRDWPeN>; Mon, 23 Apr 2001 11:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135372AbRDWPd7>; Mon, 23 Apr 2001 11:33:59 -0400
Received: from ns.suse.de ([213.95.15.193]:4360 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135353AbRDWPdN>;
	Mon, 23 Apr 2001 11:33:13 -0400
Date: Mon, 23 Apr 2001 17:33:04 +0200
From: Andi Kleen <ak@suse.de>
To: =?iso-8859-1?Q?R=EDkhar=F0ur_Egilsson?= 
	<Rikhardur.EGILSSON@oecd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.2.19 reiserfs] vs-8345: get_mem_for_virtual_node: kmalloc failed.
Message-ID: <20010423173304.A14856@gruyere.muc.suse.de>
In-Reply-To: <20010423172035.A4359@OECD.OECD.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010423172035.A4359@OECD.OECD.ORG>; from Rikhardur.EGILSSON@oecd.org on Mon, Apr 23, 2001 at 05:20:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 05:20:35PM +0200, Ríkharður Egilsson wrote:
> Is there anything I can do to prevent this from happening ?
> 
> This (squid) server, serves about 50 requests/sec, so 2 minutes of downtime
> means a lot of unhappy "customers". 

The atomic allocations for incoming packets probably overwhelm the memory
system. Try to increase the values (*2,*3) in /proc/sys/vm/freepages, 
that'll keep more memory free for interrupts and flush more aggressively. 
It may also help a bit to change the rx_copybreak argument of the network 
driver.

-Andi

