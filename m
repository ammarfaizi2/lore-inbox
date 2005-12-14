Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVLNTUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVLNTUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVLNTUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:20:19 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:34772 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964900AbVLNTUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:20:18 -0500
In-Reply-To: <20051214184147.GO23384@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netdev-owner@vger.kernel.org, sri@us.ibm.com
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF064EFE49.6C80BD18-ON882570D7.00695B9C-882570D7.006A3661@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 14 Dec 2005 11:20:59 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 12/14/2005 12:21:07,
	Serialize complete at 12/14/2005 12:21:07
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has a lot
> more users that compete true, but likely the set of GFP_CRITICAL users
> would grow over time too and it would develop the same problem.

        No, because the critical set is determined by the user (by setting
the socket flag).
        The receive side has some things marked as "critical" until we
have processed enough to check the socket flag, but then they should
be released. Those short-lived allocations and frees are more or less
0 net towards the pool.
        Certainly, it wouldn't work very well if every socket is
marked as "critical", but with an adequate pool for the workload, I
expect it'll work as advertised (esp. since it'll usually be only one
socket associated with swap management that'll be critical).

                                                                +-DLS

