Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUJFJgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUJFJgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 05:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbUJFJgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 05:36:41 -0400
Received: from colino.net ([213.41.131.56]:51961 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S269164AbUJFJgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:36:39 -0400
Date: Wed, 6 Oct 2004 11:35:41 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S.Miller" <davem@davemloft.net>
Subject: Re: Netconsole & sungem: hang when link down
Message-ID: <20041006113541.5d395ffa@pirandello>
In-Reply-To: <1097053738.16741.58.camel@gaston>
References: <20041006083954.0abefe57@pirandello>
	<1097050605.21132.17.camel@gaston>
	<20041006104251.29dcd38c@pirandello>
	<1097053738.16741.58.camel@gaston>
X-Mailer: Sylpheed-Claws 0.9.12cvs122.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Oct 2004 at 19h10, Benjamin Herrenschmidt wrote:

Hi, 

> Hrm... we have some sort of spinlock debugging, at least on ppc64...
> BTW, did you have SMP or PREEMPT ? If none of these, then you should
> not see any spin deadlock...

No, in fact. You're right...
Indeed, if there was a deadlock, it would also happen when cable is
plugged in, wouldn't it ? (as sungem outputs "Link is up at xxx..." or
something when correctly initialized).

> The solution is to look at the code though and find what's wrong :)

I'll try. 
The called method in the driver when calling 
  dev_change_flags(ndev, ndev->flags | IFF_UP) from netpoll
is
  gem_open(), if I'm not mistaken?

Could some kind of infinite loop happen within gem_link_timer, maybe ?

-- 
Colin
