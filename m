Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292393AbSCDOtU>; Mon, 4 Mar 2002 09:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292395AbSCDOtL>; Mon, 4 Mar 2002 09:49:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49925 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292393AbSCDOtA>; Mon, 4 Mar 2002 09:49:00 -0500
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Mon, 4 Mar 2002 15:04:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org> from "Jeff V. Merkey" at Mar 04, 2002 12:12:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hu0P-0007yq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> provided for review.  Recommend a minumum change of increasing 
> the sysctl_hot_list_len from 128 to 1024 by default.  I have reviewed 

Good way to kill low end boxes. It probably wants sizing based on system
size and load monitoring. 

> NetWare always created ECB's (Event Control Blocks) at the max size
> of the network adpapter rather than trying to allocate fragment 
> elements on the fly the way is being done in Linux with skb's.  

Thats up to the network adapter. In fact the Linux drivers mostly do 
keep preloaded with full sized buffers and only copy if the packet size
is small (and copying 1 or 2 cache lines isnt going to hurt anyone)

>  28044 default_idle                             584.2500

You spent most of your time asleep 8)

>   1117 __rdtsc_delay                             34.9062

Or doing delays

>    927 eth_type_trans                             4.4567

And pulling a line into L1 cache

