Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269468AbSIRW7p>; Wed, 18 Sep 2002 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269482AbSIRW7p>; Wed, 18 Sep 2002 18:59:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49294 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269468AbSIRW7o>;
	Wed, 18 Sep 2002 18:59:44 -0400
Date: Wed, 18 Sep 2002 15:55:34 -0700 (PDT)
Message-Id: <20020918.155534.102954410.davem@redhat.com>
To: greearb@candelatech.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: send-to-self [link to non-broken patch
 this time]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D8826BE.5090007@candelatech.com>
References: <3D88217A.6070702@candelatech.com>
	<3D8826BE.5090007@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 18 Sep 2002 00:09:50 -0700
   
   http://www.candelatech.com/sts_2.4.19.patch

I don't think I'll be applying this:

1) No tcp ipv6 bits
2) SIOC{S,G}ACCEPTLOCALADDRS added, but no 32-bit translation
   code added to varions 64-bit/32-bit biarch port ioctl handling.
   Also, no code added to the ioctl dispatch in the networking
   so that devices could actually receive these requests.
3) Finally, it's just too damn ugly.  If you have to ifdef it then
   it really doesn't belong in the tree.  Maybe if the device number
   comparison logic changes existed via macros in tcp.h and thus
   removing all the CONFIG_NET_SENDTOSELF ifdefs from tcp*.c code
   it might be more palatable.
4) I haven't reviewed the ramifications of the route lookup changes,
   that is Alexey's territory.

Sorry, these changes are pretty ugly right now.
