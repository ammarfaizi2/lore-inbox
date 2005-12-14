Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVLNSlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVLNSlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVLNSlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:41:51 -0500
Received: from mx1.suse.de ([195.135.220.2]:53193 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964874AbVLNSlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:41:50 -0500
Date: Wed, 14 Dec 2005 19:41:47 +0100
From: Andi Kleen <ak@suse.de>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051214184147.GO23384@wotan.suse.de>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com> <20051214092228.GC18862@brahms.suse.de> <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here we are assuming that the pre-allocated critical page pool is big enough
> to satisfy the requirements of all the critical sockets.

That seems like a lot of assumptions. Is it really better than the 
existing GFP_ATOMIC which works basically the same?  It has a lot
more users that compete true, but likely the set of GFP_CRITICAL users
would grow over time too and it would develop the same problem.

I think if you really want to attack this problem and improve
over the GFP_ATOMIC "best effort in smaller pool" approach you should
probably add real reservations. And then really do a lot of testing
to see if it actually helps.

-Andi
