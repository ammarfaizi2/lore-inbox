Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJQTbM>; Thu, 17 Oct 2002 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJQTbM>; Thu, 17 Oct 2002 15:31:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3006 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261907AbSJQTbL>;
	Thu, 17 Oct 2002 15:31:11 -0400
Date: Thu, 17 Oct 2002 12:29:38 -0700 (PDT)
Message-Id: <20021017.122938.68134789.davem@redhat.com>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offload (TSO) in 2.4?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210171105.14964.roy@karlsbakk.net>
References: <200210171105.14964.roy@karlsbakk.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
   Date: Thu, 17 Oct 2002 11:05:14 +0200

   I've got some servers doing quite a lot of network traffic, and after reading 
   the article about TSO on kernel traffic 
   (http://www.kerneltrap.org/node.php?id=397), I wonder ... will this be 
   backported to 2.4? is it hard?

It isn't hard, but two issues:

1) You'll only get this with e1000 cards, and there were some
   performance regression noted by some testers at IBM with
   TSO enabled.

2) There are semantic issues still unresolved in the generic
   TCP implementation parts, such as how to deal with the
   fact that the way to get the most out of TSO is to
   ignore the congestion window at connection startup.  We
   can only really make such a violation when talking to a
   host on the local network etc. etc.

   A 2.4.x backport is illadvisable until this is resolved.
