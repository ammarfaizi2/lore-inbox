Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262529AbSI1B3l>; Fri, 27 Sep 2002 21:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262676AbSI1B3l>; Fri, 27 Sep 2002 21:29:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42134 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262529AbSI1B3l>;
	Fri, 27 Sep 2002 21:29:41 -0400
Date: Fri, 27 Sep 2002 18:28:33 -0700 (PDT)
Message-Id: <20020927.182833.66704359.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020928.001742.125874265.yoshfuji@linux-ipv6.org>
References: <20020928.001742.125874265.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Sat, 28 Sep 2002 00:17:42 +0900 (JST)

Please redesign this structure.

   +struct addrselect_attrs {
   +	struct inet6_ifaddr *ifp;
   +	int	match;
   +	int	deprecated;
   +	int	home;
   +	int	temporary;
   +	int	device;
   +	int	scope;
   +	int	label;
   +	int	matchlen;
   +};

This is much larger than it needs to be.  Please replace these "int"
binary states with single "u32 flags;" and appropriate bit
definitions.

This structure sits on the stack, so it is important to be
as small as we can easily make it.

Otherwise I have no problems with the patch, Alexey?
