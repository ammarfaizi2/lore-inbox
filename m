Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWBLQhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWBLQhv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWBLQhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:37:51 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:46141 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751145AbWBLQhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:37:51 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [git patch review 1/4] IPoIB: Don't start
 send-only joins while multicast thread is stopped
X-Message-Flag: Warning: May contain useful information
References: <1139689341370-68b63fa9b8e76d91@cisco.com>
	<20060211140209.57af1b16.akpm@osdl.org> <ada8xsh49ll.fsf@cisco.com>
	<20060212075037.GA11550@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 12 Feb 2006 08:37:48 -0800
In-Reply-To: <20060212075037.GA11550@mellanox.co.il> (Michael S. Tsirkin's
 message of "Sun, 12 Feb 2006 09:50:37 +0200")
Message-ID: <adazmkw3543.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 12 Feb 2006 16:37:49.0870 (UTC) FILETIME=[A97BECE0:01C62FF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Basically, its as Andrew said: the lock around clear_bit
    Michael> is there to ensure that ipoib_mcast_send isnt running
    Michael> already when we stop the thread.  Thats why test_bit has
    Michael> to be inside the lock, too.

Makes sense I guess.  If I'm understanding correctly, the lock isn't
really there to serialize the bit ops, but rather to make sure
ipoib_mcast_send() won't do anything after we clear the bit.

Does that mean that there's no reason to take the lock around the set_bit()?

 - R.
