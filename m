Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUINTzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUINTzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269367AbUINTye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:54:34 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40460 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269628AbUINTuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:50:40 -0400
Date: Tue, 14 Sep 2004 21:47:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arnout Engelen <arnouten@bzzt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/net/tcp documentation
Message-ID: <20040914194723.GG2780@alpha.home.local>
References: <20040914171057.GF11646@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914171057.GF11646@bzzt.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a useful document.

Would you mind resending it to maintainers (and here) as a patch against
recent kernels (2.4 and 2.6), so that they may consider its inclusion ?
For example, put it in Documentation/networking/proc_net_tcp, or with
the rest of /proc description.

Thanks,
Willy

On Tue, Sep 14, 2004 at 07:10:57PM +0200, Arnout Engelen wrote:
> /proc/net/tcp and /proc/net/tcp6
> 
> These /proc interfaces provide information about currently active TCP 
> connections, and are implemented by tcp_get_info() in net/ipv4/tcp_ipv4.c and
> tcp6_get_info() in net/ipv6/tcp_ipv6.c, respectively.
> 
> It will first list all listening TCP sockets, and next list all established
> TCP connections. A typical entry of /proc/net/tcp would look like this (split 
> up into 3 parts because of the length of the line):
> 
>    46: 010310AC:9C4C 030310AC:1770 01 
>    |      |      |      |      |   |--> connection state
>    |      |      |      |      |------> remote TCP port number
>    |      |      |      |-------------> remote IPv4 address
>    |      |      |--------------------> local TCP port number
>    |      |---------------------------> local IPv4 address
>    |----------------------------------> number of entry
> 
>    00000150:00000000 01:00000019 00000000  
>       |        |     |     |       |--> number of unrecovered RTO timeouts
>       |        |     |     |----------> number of jiffies until timer expires
>       |        |     |----------------> timer_active (see below)
>       |        |----------------------> receive-queue
>       |-------------------------------> transmit-queue
> 
>    1000        0 54165785 4 cd1e6040 25 4 27 3 -1
>     |          |    |     |    |     |  | |  | |--> slow start size threshold, 
>     |          |    |     |    |     |  | |  |      or -1 if the treshold
>     |          |    |     |    |     |  | |  |      is >= 0xFFFF
>     |          |    |     |    |     |  | |  |----> sending congestion window
>     |          |    |     |    |     |  | |-------> (ack.quick<<1)|ack.pingpong
>     |          |    |     |    |     |  |---------> Predicted tick of soft clock
>     |          |    |     |    |     |              (delayed ACK control data)
>     |          |    |     |    |     |------------> retransmit timeout
>     |          |    |     |    |------------------> location of socket in memory
>     |          |    |     |-----------------------> socket reference count
>     |          |    |-----------------------------> inode
>     |          |----------------------------------> unanswered 0-window probes
>     |---------------------------------------------> uid
> 
> timer_active:
>   0  no timer is pending
>   1  retransmit-timer is pending
>   2  another timer (e.g. delayed ack or keepalive) is pending
>   3  this is a socket in TIME_WAIT state. Not all field will contain data.
>   4  zero window probe timer is pending

