Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbTGDCek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbTGDCda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:33:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63203 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265755AbTGDCcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:32:41 -0400
Message-ID: <3F04EAA0.2050102@pobox.com>
Date: Thu, 03 Jul 2003 22:46:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
References: <200307032231.39842.jeffpc@optonline.net>
In-Reply-To: <200307032231.39842.jeffpc@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek wrote:
> +	spinlock_t	rx_packets;
> +	spinlock_t	tx_packets;
> +	spinlock_t	rx_bytes;
> +	spinlock_t	tx_bytes;
> +	spinlock_t	rx_errors;
> +	spinlock_t	tx_errors;
> +	spinlock_t	rx_dropped;
> +	spinlock_t	tx_dropped;
> +	spinlock_t	multicast;
> +	spinlock_t	collisions;
> +	spinlock_t	rx_length_errors;
> +	spinlock_t	rx_over_errors;
> +	spinlock_t	rx_crc_errors;
> +	spinlock_t	rx_frame_errors;
> +	spinlock_t	rx_fifo_errors;
> +	spinlock_t	rx_missed_errors;
> +	spinlock_t	tx_aborted_errors;
> +	spinlock_t	tx_carrier_errors;
> +	spinlock_t	tx_fifo_errors;
> +	spinlock_t	tx_heartbeat_errors;
> +	spinlock_t	tx_window_errors;
> +	spinlock_t	rx_compressed;
> +	spinlock_t	tx_compressed;

That's a fat daddy list of locks you got there.


> +	NETSTAT_TYPE	_rx_packets;		/* total packets received	*/
> +	NETSTAT_TYPE	_tx_packets;		/* total packets transmitted	*/
> +	NETSTAT_TYPE	_rx_bytes;		/* total bytes received 	*/
> +	NETSTAT_TYPE	_tx_bytes;		/* total bytes transmitted	*/
> +	NETSTAT_TYPE	_rx_errors;		/* bad packets received		*/
> +	NETSTAT_TYPE	_tx_errors;		/* packet transmit problems	*/
> +	NETSTAT_TYPE	_rx_dropped;		/* no space in linux buffers	*/
> +	NETSTAT_TYPE	_tx_dropped;		/* no space available in linux	*/
> +	NETSTAT_TYPE	_multicast;		/* multicast packets received	*/
> +	NETSTAT_TYPE	_collisions;

Increasing user-visible sizes arbitrarily breaks stuff.  Having 
config-dependent types like this increases complexity.

Short term, just sample the stats more rapidly.

Long term, I suppose with 10GbE we should start thinking about this. 
Personally, I would prefer to make the standard net device stats 
available in the format already exported by ETHTOOL_GSTATS -- which I 
note uses u64's for its counters, and it's easily extensible.  I 
received a request for this just today, even.

	Jeff


P.S.  Please cc netdev@oss.sgi.com for networking discussions.

