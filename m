Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWBLIRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWBLIRz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 03:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWBLIRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 03:17:55 -0500
Received: from [194.90.237.34] ([194.90.237.34]:20945 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932341AbWBLIRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 03:17:55 -0500
Date: Sun, 12 Feb 2006 10:19:10 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: Re: [git patch review 1/4] IPoIB: Don't start send-only joins while multicast thread is stopped
Message-ID: <20060212081910.GA11812@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1139689341370-68b63fa9b8e76d91@cisco.com> <20060211140209.57af1b16.akpm@osdl.org> <ada8xsh49ll.fsf@cisco.com> <20060212075037.GA11550@mellanox.co.il> <BF4A90F5-149D-4627-A350-48CC4D214C28@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF4A90F5-149D-4627-A350-48CC4D214C28@mac.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Feb 2006 08:19:40.0906 (UTC) FILETIME=[1245F4A0:01C62FAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Kyle Moffett <mrmacman_g4@mac.com>:
> On Feb 12, 2006, at 02:50, Michael S. Tsirkin wrote:
> >Basically, its as Andrew said: the lock around clear_bit is there  
> >to ensure that ipoib_mcast_send isnt running already when we stop  
> >the thread.  Thats why test_bit has to be inside the lock, too.
> 
> Looks like you guys could use nonatomic versions to improve bus  
> efficiency slightly

I think we need atomics since other places touch bits in the same word without
taking the lock.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
