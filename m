Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVJ3RcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVJ3RcI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJ3RcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:32:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:44947 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751089AbVJ3RcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:32:07 -0500
In-Reply-To: <4364EA58.7040707@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netdev-owner@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]IPv6: doubt about ipv6_sk_mc_lock usage.
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFE9824801.1D574FF8-ON882570AA.005FC39C-882570AA.006050CD@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Sun, 30 Oct 2005 09:32:14 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 10/30/2005 10:32:19,
	Serialize complete at 10/30/2005 10:32:19
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, ipv6_sk_mc_lock is required for join and leave to protect 
inet6_mc_check()
calls, and modifications to the filter list only happen via ioctls that 
are protected
by the socket lock.

I don't think any of these changes are correct.

                                                +-DLS


netdev-owner@vger.kernel.org wrote on 10/30/2005 07:44:24 AM:

> Hello.
> 
> I think ipv6_sk_mc_lock should protest both ipv6_mc_list and it's 
sflist. 
> because they can are used by 
> inet6_mc_check(...) in softirq and be modified by ip6_mc_source(...) or 
> ip6_mc_msfilter(...) simultaneity.
> I also remove read_lock when traverse ipv6_mc_list, because it's 
protected by 
> lock_sock(sk).
> 

