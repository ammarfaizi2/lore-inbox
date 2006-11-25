Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966637AbWKYW4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966637AbWKYW4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967284AbWKYW4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:56:25 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:20403 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S966637AbWKYW4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:56:24 -0500
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 25 Nov 2006 14:56:22 -0800
In-Reply-To: <20061124.220746.57445336.davem@davemloft.net> (David Miller's message of "Fri, 24 Nov 2006 22:07:46 -0800 (PST)")
Message-ID: <adaodqv5e5l.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Nov 2006 22:56:23.0393 (UTC) FILETIME=[EDF0FD10:01C710E4]
Authentication-Results: sj-dkim-6; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim6002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Perhaps a better way to fix this is to use
 > typeof() like other similar macros do.

I tried doing

#define ALIGN(x,a)				\
	({					\
		typeof(x) _a = (a);		\
		((x) + _a - 1) & ~(_a - 1);	\
	})

but that won't compile because of <net/neighbour.h>:

	unsigned char		ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))];

gcc says:

/scratch/Ksrc/linux-merge/include/net/neighbour.h:104: error: braced-group within expression allowed only inside a function

I guess that could be fixed by changing that declaration but now this
is starting to feel like early 2.6.20 material.

 - R.
