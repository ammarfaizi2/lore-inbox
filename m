Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311220AbSCLTxX>; Tue, 12 Mar 2002 14:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311232AbSCLTxN>; Tue, 12 Mar 2002 14:53:13 -0500
Received: from h00403399c977.ne.client2.attbi.com ([24.218.248.214]:38536 "EHLO
	fred.cambridge.ma.us") by vger.kernel.org with ESMTP
	id <S311220AbSCLTxH>; Tue, 12 Mar 2002 14:53:07 -0500
From: pjd@fred001.dynip.com
Message-Id: <200203121952.g2CJqxx31507@fred.cambridge.ma.us>
Subject: Re: [patch] ns83820 0.17
To: davem@redhat.com (David S. Miller)
Date: Tue, 12 Mar 2002 14:52:59 -0500 (EST)
Cc: tadams-lists@myrealbox.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020312.101713.106542707.davem@redhat.com> from "David S. Miller" at Mar 12, 2002 10:17:13 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> 
> I said we don't need NAPI for just bandwidth streams, you mention
> routing which is specifically the case I mention that NAPI is good for
> (high packet rates).

In particular, if you have a small number of high-speed streams the 
TCP window mechanism will protect against receive livelock.  (actually
a medium number of streams would still be protected - it's not until
the total offered window size in packets exceeds the input packet 
queue size that you would become vulnerable to livelock)

Routing, on the other hand, can be driven into a state where you spend
all your CPU processing receive interrupts, and no CPU actually 
forwarding the packets, for a net throughput approaching zero.  

Peter Desnoyers
