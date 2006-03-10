Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWCJAi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWCJAi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWCJAi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:38:28 -0500
Received: from [194.90.237.34] ([194.90.237.34]:39483 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932420AbWCJAhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:37:55 -0500
Date: Fri, 10 Mar 2006 02:38:11 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, shemminger@osdl.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060310003811.GA23187@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <adaacc1raz9.fsf@cisco.com> <20060307.172336.107863253.davem@davemloft.net> <20060308125311.GE17618@mellanox.co.il> <20060309.154819.104282952.davem@davemloft.net> <20060310001031.GA19040@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310001031.GA19040@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Mar 2006 00:40:19.0468 (UTC) FILETIME=[351DC4C0:01C643DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Michael S. Tsirkin <mst@mellanox.co.il>:
> Or does __tcp_ack_snd_check delay until we have at least two full sized
> segments?

What I'm trying to say, since RFC 2525, 2.13 talks about
"every second full-sized segment", so following the code from
__tcp_ack_snd_check, why does it do

	    /* More than one full frame received... */
	if (((tp->rcv_nxt - tp->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss

rather than

	    /* At least two full frames received... */
	if (((tp->rcv_nxt - tp->rcv_wup) >= 2 * inet_csk(sk)->icsk_ack.rcv_mss

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
