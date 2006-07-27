Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWG0IUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWG0IUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWG0IUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:20:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32415
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750762AbWG0IUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:20:18 -0400
Date: Thu, 27 Jul 2006 01:20:37 -0700 (PDT)
Message-Id: <20060727.012037.78156999.davem@davemloft.net>
To: axboe@suse.de
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060727081114.GH5282@suse.de>
References: <20060727.010255.87351515.davem@davemloft.net>
	<20060727080901.GG5282@suse.de>
	<20060727081114.GH5282@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Thu, 27 Jul 2006 10:11:15 +0200

> Ownership transition from user -> kernel that is, what I'm trying to say
> that returning ownership to the user again is the tricky part.

Yes, it is important that for TCP, for example, we don't give
the user the event until the data is acknowledged and the skb's
referencing that data are fully freed.

This is further complicated by the fact that packetization boundaries
are going to be different from AIO buffer boundaries.

I think this is what you are alluding to.
