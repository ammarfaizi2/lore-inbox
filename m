Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSJCRiD>; Thu, 3 Oct 2002 13:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSJCRiD>; Thu, 3 Oct 2002 13:38:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33492 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261641AbSJCRiC>;
	Thu, 3 Oct 2002 13:38:02 -0400
Date: Thu, 03 Oct 2002 10:36:17 -0700 (PDT)
Message-Id: <20021003.103617.04446177.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Miscellaneous clean-ups
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021004.011315.05129566.yoshfuji@linux-ipv6.org>
References: <20021004.011315.05129566.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Fri, 04 Oct 2002 01:13:15 +0900 (JST)

   @@ -1187,7 +1187,7 @@
    	ASSERT_RTNL();
    
    	memset(&addr, 0, sizeof(struct in6_addr));
   -	addr.s6_addr[15] = 1;
   +	addr.s6_addr32[3] = __constant_htonl(0x00000001);
    
Do not use __constant_htonl() in runtime code, use htonl().
Arnaldo de Melo told you this the other day for another one
of your patches, so you must fix this kind of stuff up before
I'll apply any of your patches which have this problem.

Only use __constant_htonl() for compile time initialization of data
built into the kernel.

Otherwise I like you patch, please fix it up so I may apply it.
