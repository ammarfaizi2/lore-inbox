Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319539AbSIMGMr>; Fri, 13 Sep 2002 02:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319540AbSIMGMr>; Fri, 13 Sep 2002 02:12:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15302 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319539AbSIMGMq>;
	Fri, 13 Sep 2002 02:12:46 -0400
Date: Thu, 12 Sep 2002 23:09:16 -0700 (PDT)
Message-Id: <20020912.230916.96754743.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209130812.27093.bart.de.schuymer@pandora.be>
References: <200209130520.41862.bart.de.schuymer@pandora.be>
	<20020912.212959.114182683.davem@redhat.com>
	<200209130812.27093.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Fri, 13 Sep 2002 08:12:27 +0200

   It is not trivial however, 2 new fields to the sk_buff need to be 
   added, a small change in the IP fragment code and a small change in 
   ip_tables.c, a change to netfilter.h and netfilter.c.

I've seen these changes, they are very buggy.  The IPv4 copies added
are just ugly and are buggy too, they potentially copy past the end
of the packet buffer.

   So, if you would accept br-nf, that would be great.

You need to remove the IPv4 bits, that copy of the MAC has to happen
at a different layer, it does not belong in IPv4.  At best, everyone
shouldn't eat that header copy.

Franks a lot,
David S. Miller
davem@redhat.com
