Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVAGHjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVAGHjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVAGHjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:39:16 -0500
Received: from ja.ssi.bg ([217.79.71.194]:14464 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id S261301AbVAGHjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:39:08 -0500
Date: Fri, 7 Jan 2005 09:44:29 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Jan De Luyck <lkml@kcore.org>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: ARP routing issue
In-Reply-To: <200501061647.45226.lkml@kcore.org>
Message-ID: <Pine.LNX.4.58.0501070935240.1636@u.domain.uli>
References: <200501061647.45226.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 6 Jan 2005, Jan De Luyck wrote:

> http://www.uwsg.iu.edu/hypermail/linux/net/0308.1/0071.html
>
> Basically it comes down to this:
>
> I have an IBM server running RH ES, kernel 2.4.9-e.49. It has two interfaces:
> eth0 10.0.22.xxx
> eth1 10.0.24.xxx
>
> default gateway is set to 10.0.22.1, on eth0.
>
> Problem is, if I try to ping from another network (10.216.0.xx) to 10.0.24.xx,
> i see the following ARP request:
>
> arp who-has 10.0.22.1 tell 10.0.24.xx
>
> which, imo, is wrong.
>
> I know it has to do with the default gatway, but I can't devise a way to make
> it actually _WORK_.

	Not wrong but it is one of the possible valid requests. If it
is ignored from other boxes in your setup then you can look 
at new kernels. 2.4.26 and 2.6.4 come with new sysctl flags for ARP. 
arp_filter filters incoming requests but you can use arp_announce to 
control the source IP when sending requests, eg. in IBM server you can set
/proc/sys/net/ipv4/conf/eth*/arp_announce to 1 or 2 or even just
/proc/sys/net/ipv4/conf/all/arp_announce to 1 or 2

> Any pointers?

See Documentation/networking/ip-sysctl.txt for more info.

> Thanks.
>
> Jan

Regards

--
Julian Anastasov <ja@ssi.bg>
