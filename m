Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030680AbWI0Tcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbWI0Tcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWI0Tcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:32:54 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:8931 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030680AbWI0Tcx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:32:53 -0400
Date: Wed, 27 Sep 2006 15:32:26 -0400
From: dhollis@davehollis.com
Subject: Re: [PATCH 1/5] UML - Assign random MACs to interfaces if	necessary
In-reply-to: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-id: <20060927153226.pem81wc3k0ko48k4@web.davehollis.com>
MIME-version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Content-disposition: inline
References: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeff Dike <jdike@addtoit.com>:

> Assign a random MAC to an ethernet interface if one was not provided on
> the command line.  This became pressing when distros started
> bringing interfaces up before assigning IPs to them.  The previous
> pattern of assigning an IP then bringing it up allowed the MAC to be
> generated from the first IP assigned.  However, once the thing is
> up, it's probably a bad idea to change the MAC, so the MAC stayed
> initialized to fe:fd:0:0:0:0.
>
> Now, if there is no MAC from the command line, one is generated.  We
> use the microseconds from gettimeofday (20 bits), plus the low 12
> bits of the pid to seed the random number generator.  random() is
> called twice, with 16 bits of each result used.  I didn't want to
> have to try to fill in 32 bits optimally given an arbitrary
> RAND_MAX, so I just assume that it is greater than 65536 and use 16
> bits of each random() return.
>
> There is also a bit of reformatting and whitespace cleanup here.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>

Couldn't you use random_ether_addr() from linux/etherdevice.h?

static inline void random_ether_addr(u8 *addr)
{
         get_random_bytes (addr, ETH_ALEN);
         addr [0] &= 0xfe;       /* clear multicast bit */
         addr [0] |= 0x02;       /* set local assignment bit (IEEE802) */
}


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

