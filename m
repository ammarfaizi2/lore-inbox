Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWARJiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWARJiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWARJiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:38:50 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48566
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932371AbWARJit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:38:49 -0500
Date: Wed, 18 Jan 2006 01:38:41 -0800 (PST)
Message-Id: <20060118.013841.123630757.davem@davemloft.net>
To: dev@openvz.org
Cc: linux-kernel@vger.kernel.org, dim@openvz.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       akpm@osdl.org
Subject: Re: [RFC][DRAFT][PATCH] iptables 32bit compat layer
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43CE0696.50407@openvz.org>
References: <43CE0696.50407@openvz.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Korotaev <dev@openvz.org>
Date: Wed, 18 Jan 2006 12:12:54 +0300

> This patch extends current iptables compatibility layer in order to get
> 32bit iptables to work on 64bit kernel. Current layer is insufficient 
> due to alignment checks both in kernel and user space tools. Current 
> draft version works correctly with standard targets only 
> (ACCEPT/DROP/FORWARD).
> 
> ToDo:
>   - extend translation to include more matches and targets. Use arrays of
>     structures like { name, size_diff, func_for_convert_data} for this
>     purpose
>   - extend get_info to return corrected size. Add size calculation to
>     get_entries.

Thanks for doing this work.

But it would make a lot more sense to add
compat_setsockopt and compat_getsockopt socket
operations, call down into there, and then implement
these translations inside of netfilter itself.

This would avoid an enormous amount of copying
and munging, and also would keep netfilter internals
outside of the generic socket compat layer code.

Thanks.
