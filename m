Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUA3XNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUA3XNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:13:45 -0500
Received: from ns1.s2io.com ([216.209.86.101]:2740 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S264374AbUA3XNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:13:43 -0500
Subject: receive path with fragmented skbs
From: Kallol Biswas <kallol.biswas@s2io.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1075504343.21310.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Jan 2004 15:12:24 -0800
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.4
X-Spam-Outlook-Score: ()
X-Spam-Features: USER_AGENT_XIMIAN,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      We have been developing drivers and networking software  on
a 10 gigabit ethernet adapter from S2io Inc (www.s2io.com). There is a
requirement that the ethernet header, IP+TCP headers have to be cache
aligned and the payload and the IP+TCP headers have to be in different
fragments. So we have created receive path skbs with data size big
enough to hold the ethernet header and two fragments, one fragment for
the IP+TCP header and the other for payload. The card can  directly dma
into the three receive scatter buffers when a frame arrives.

We could not get ping working with this design of receive skbs,
but if a skb is linearized with skb_linearize() before calling
netif_rx(), ping works.

/proc/net/snmp was printed, no frame had any error. Probably no one has
ever tested the receive path of the stack with fragmented skbs, am I
right? One of the ways this problem can be debugged is to find out where
exactly the packets get dropped. Any comment?

Kallol 

