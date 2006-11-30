Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967773AbWK3BBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967773AbWK3BBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967771AbWK3BBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:01:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37773
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S967770AbWK3BBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:01:38 -0500
Date: Wed, 29 Nov 2006 17:01:41 -0800 (PST)
Message-Id: <20061129.170141.23017532.davem@davemloft.net>
To: wenji@fnal.gov
Cc: netdev@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Bug 7596 - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <HNEBLGGMEGLPMPPDOPMGKEAJCGAA.wenji@fnal.gov>
References: <HNEBLGGMEGLPMPPDOPMGKEAJCGAA.wenji@fnal.gov>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The delays dealt with in your paper might actually help a highly
loaded server with lots of sockets and threads trying to communicate.

The packet processing delays caused by the scheduling delay paces the
TCP sender by controlling the rate at which ACKs go back to that
sender.  Those ACKs will go out paced to the rate at which the
sleeping TCP receiver gets back onto the cpu, and this will cause the
TCP sender to naturally adjust to the overall processing rate of the
receiver system, on a per-connection basis.

Perhaps try a system with hundreds of processes and potentially
hundreds of thousands of TCP sockets, with thousands of unique sender
sites, and see what happens.

This is a similar topic like TSO, where we are trying to balance the
gains from batching work from the losses of gaps in the communication
stream.
