Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSI0J0T>; Fri, 27 Sep 2002 05:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbSI0J0T>; Fri, 27 Sep 2002 05:26:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:144 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261660AbSI0J0S>;
	Fri, 27 Sep 2002 05:26:18 -0400
Date: Fri, 27 Sep 2002 02:25:15 -0700 (PDT)
Message-Id: <20020927.022515.78074730.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] IPv6: Refine IPv6 Address Validation Timer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020927.181256.112824147.yoshfuji@linux-ipv6.org>
References: <20020927.181256.112824147.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Fri, 27 Sep 2002 18:12:56 +0900 (JST)

This patch has problems.
    
   @@ -1626,24 +1635,32 @@
    		for (ifp=inet6_addr_lst[i]; ifp; ifp=ifp->lst_next) {
    			unsigned long age;
    
   -			if (ifp->flags & IFA_F_PERMANENT)
   +			spin_lock(&ifp->lock);
   +			if (ifp->flags & IFA_F_PERMANENT) {
   +				spin_unlock(&ifp->lock);
    				continue;
   +			}

This is completely unnecessary.  Nobody modifies the
IFA_F_PERMANENT flag after the addr entry has been added
to the hash table and this runs under the addrconf hash
lock already.

Alexey will have to comment on the rest.
