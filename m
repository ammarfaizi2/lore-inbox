Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTIZTEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTIZTEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 15:04:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:8595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261602AbTIZTER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 15:04:17 -0400
Date: Fri, 26 Sep 2003 12:03:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Alexey V. Yurchenko" <ayurchen@path.emicnetworks.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: how to set multicast MAC ligitemately?
Message-Id: <20030926120345.6668d96f.shemminger@osdl.org>
In-Reply-To: <20030926215326.23f7de24.ayurchen@mail.emicnetworks.com>
References: <20030926215326.23f7de24.ayurchen@mail.emicnetworks.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 21:53:26 +0300
"Alexey V. Yurchenko" <ayurchen@path.emicnetworks.com> wrote:

> 
> Hi, everybody
> 
> In view of include/linux/etherdevice.h:
> 
> ...
> /**
>  * is_valid_ether_addr - Determine if the given Ethernet address is valid
>  * @addr: Pointer to a six-byte array containing the Ethernet address
>  *
>  * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
>  * a multicast address, and is not FF:FF:FF:FF:FF:FF.  The multicast
>  * and FF:FF:... tests are combined into the single test "!(addr[0]&1)".
>  *
>  * Return true if the address is valid.
>  */
> static inline int is_valid_ether_addr( u8 *addr )
> {
>         const char zaddr[6] = {0,};
>                                                                           
>         return !(addr[0]&1) && memcmp( addr, zaddr, 6);
> }
> ...
> 
> how it is possible to set up multicast MAC address legitemately if NIC driver resorts to use of this function. Why are multicast addresses forbidden and who is the right person to ask?
> 
> (I really do need to set a multicast MAC address, and if multicast MAC addresses exist, why are they forbidden?)
> 
> Regards,
> Alex

Not interface should have a multicast MAC address. A multicast address
should only exist as a destination address, never a source.
