Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTAIIjt>; Thu, 9 Jan 2003 03:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTAIIjt>; Thu, 9 Jan 2003 03:39:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45548 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261934AbTAIIjr>;
	Thu, 9 Jan 2003 03:39:47 -0500
Date: Thu, 09 Jan 2003 00:39:29 -0800 (PST)
Message-Id: <20030109.003929.89643598.davem@redhat.com>
To: usagi-core@linux-ipv6.org, Kazunori.Miyazawa@jp.yokogawa.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: (usagi-core 11007) [PATCH] IPsec Configuration Extension for
 IPv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030107130050.0903bf59.Kazunori.Miyazawa@jp.yokogawa.com>
References: <20030107130050.0903bf59.Kazunori.Miyazawa@jp.yokogawa.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kazunori Miyazawa <Kazunori.Miyazawa@jp.yokogawa.com>
   Date: Tue, 7 Jan 2003 13:00:50 +0900

   This patch is simple extension of PF_KEY to support IPv6;
   to accept IPv6 IPsec configurations.
   
Ok.  Your patch looks OK and probably I will integrate it to my
tree tomorrow.

   However this patch does not contain any codes to process the packets 
   in IPv6 stack because we wonder how we should implement it:
   
   1. The building packet codes of datagram (ip_append_data()) is 
      very different from ip6_build_xmit(). And I guess you will
      change ip6_build_xmit() to ip6_append_data().
   
   2. How should we implement to process destination option header 
      which is inside of AH and/or ESP?  There seems two options. 
      One is to process IPsec on parsing extension headers.
      The other is to process IPsec as upper layer protocol and 
      we always check the destination option header when we finish 
      to process AH or ESP.
   
   We will be glad to hear your preferences, plans or a better way 
   to implementation.
   
To be honest no concrete plans exist.  Alexey is currently
offline and I expected to bring him into an ipv6 ipsec discussion
as soon as he reappears.  I do not know when he will return, however.

Because of this, I would suggest to just keep working in area of
AH/ESP ipv6-specific packet creation and parsing.  Stay clear of
routing/dst/input/output interface issues.  If you finish the packet
handling/building work and Alexey does not return, we can work on
design without him.
