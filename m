Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVJaBoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVJaBoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJaBo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:44:29 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:6893 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751272AbVJaBo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:44:28 -0500
Message-ID: <4365775B.9080209@21cn.com>
Date: Mon, 31 Oct 2005 09:46:03 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Stevens <dlstevens@us.ibm.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MCAST]IPv6: doubt about ipv6_sk_mc_lock usage.
References: <OFE9824801.1D574FF8-ON882570AA.005FC39C-882570AA.006050CD@us.ibm.com>
In-Reply-To: <OFE9824801.1D574FF8-ON882570AA.005FC39C-882570AA.006050CD@us.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: rVAlY6OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Stevens wrote:
> No, ipv6_sk_mc_lock is required for join and leave to protect 
> inet6_mc_check()
> calls, and modifications to the filter list only happen via ioctls that 
> are protected
> by the socket lock.
> 
> I don't think any of these changes are correct.
> 
>                                                 +-DLS

Thanks.

I have one more question. 
Why ip6_mc_source() uses read_lock_bh(&ipv6_sk_mc_lock) and ip6_mc_msfilter() doesn't use ipv6_sk_mc_lock at all. 
when ipv6_mc_list's sflist are accessed by inet6_mc_check(), Can it be modified by ip6_mc_source() or ip6_mc_msfilter() ?
(For example ipv6_mc_list's sflist is freed up by sock_kfree_s(), when inet6_mc_check() uses it)


                                                                   Regards
