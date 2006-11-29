Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936104AbWK2XmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936104AbWK2XmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935099AbWK2XmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:42:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:63710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934499AbWK2XmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:42:06 -0500
Date: Wed, 29 Nov 2006 15:42:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: wenji@fnal.gov
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: Bug 7596 - Potential performance bottleneck for Linxu TCP
Message-Id: <20061129154200.c4db558c.akpm@osdl.org>
In-Reply-To: <HNEBLGGMEGLPMPPDOPMGKEAJCGAA.wenji@fnal.gov>
References: <HNEBLGGMEGLPMPPDOPMGKEAJCGAA.wenji@fnal.gov>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 17:22:10 -0600
Wenji Wu <wenji@fnal.gov> wrote:

> From: Wenji Wu <wenji@fnal.gov>
> 
> Greetings,
> 
> For Linux TCP, when the network applcaiton make system call to move data
> from
> socket's receive buffer to user space by calling tcp_recvmsg(). The socket
> will
> be locked. During the period, all the incoming packet for the TCP socket
> will go
> to the backlog queue without being TCP processed. Since Linux 2.6 can be
> inerrupted mid-task, if the network application expires, and moved to the
> expired array with the socket locked, all the packets within the backlog
> queue
> will not be TCP processed till the network applicaton resume its execution.
> If
> the system is heavily loaded, TCP can easily RTO in the Sender Side.
> 
> Attached is the detailed description of the problem and one possible
> solution.

Thanks.  The attachment will be too large for the mailing-list servers so I
uploaded a copy to
http://userweb.kernel.org/~akpm/Linux-TCP-Bottleneck-Analysis-Report.pdf

>From a quick peek it appears that you're getting around 10% improvement in
TCP throughput, best case.

