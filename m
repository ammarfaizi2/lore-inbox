Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbTFMWZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTFMWZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:25:22 -0400
Received: from dp.samba.org ([66.70.73.150]:34515 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265563AbTFMWZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:25:21 -0400
Date: Sat, 14 Jun 2003 08:38:41 +1000
From: Anton Blanchard <anton@samba.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Herman Dierks <hdierks@us.ibm.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       David Gibson <dwg@au1.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nancy J Milliner <milliner@us.ibm.com>,
       Ricardo C Gonzalez <ricardoz@us.ibm.com>,
       Brian Twichell <twichell@us.ibm.com>, netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
Message-ID: <20030613223841.GB32097@krispykreme>
References: <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com> <1055521263.3531.2055.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055521263.3531.2055.camel@nighthawk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wouldn't you get most of the benefit from copying that stuff around in
> the driver if you allocated the skb->data aligned in the first place? 

Nice try, but my understanding is that on the transmit path we reserve
the maximum sized TCP header, copy the data in then form our TCP header
backwards from that point. Since the TCP header size changes with
various options, its not an easy task.

One thing I thought of doing was to cache the current TCP header size
and align the next packet based on it, with an extra cacheline at the
start for it to spill into if the TCP header grew.

This is only worth it if most packets will have the same sized header.
Networking guys: is this a valid assumption?

Anton
