Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbSI1CrX>; Fri, 27 Sep 2002 22:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSI1CrX>; Fri, 27 Sep 2002 22:47:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16535 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262688AbSI1CrX>;
	Fri, 27 Sep 2002 22:47:23 -0400
Date: Fri, 27 Sep 2002 19:35:41 -0700 (PDT)
Message-Id: <20020927.193541.89132835.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209280228.GAA02633@sex.inr.ac.ru>
References: <20020927.182833.66704359.davem@redhat.com>
	<200209280228.GAA02633@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Sat, 28 Sep 2002 06:28:29 +0400 (MSD)

   > Otherwise I have no problems with the patch, Alexey?
   
   I have... The implementation is bad. Source address must be retieved
   from route, not running this elephant function each packet.
   
This only runs at connect time, and when NULL fl->fl6_src is seen
by ip6_build_xmit() (this means RAW,UDP,ICMP which must make these
decisions anyways).

Is there really so much computation to be saved by moving this
to ipv6 route?

