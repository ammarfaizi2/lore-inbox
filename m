Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVIBFTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVIBFTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 01:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVIBFTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 01:19:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbVIBFTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 01:19:17 -0400
Date: Thu, 1 Sep 2005 22:20:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Noritoshi Demizu <demizu@dd.iij4u.or.jp>
Cc: Ion Badulescu <lists@limebrokerage.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent
 2.4.x/2.6.x kernels
Message-ID: <20050901222032.5cc649c0@localhost.localdomain>
In-Reply-To: <20050902.135138.38716488.Noritoshi@Demizu.ORG>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
	<20050902.135138.38716488.Noritoshi@Demizu.ORG>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Sep 2005 13:51:38 +0900 (JST)
Noritoshi Demizu <demizu@dd.iij4u.or.jp> wrote:

> Below may not be directly related to the cause of the problem.
> But I think some window sizes in your mail need to be re-evaluated.
> 
> > 11:29:54.961998 10.2.20.246.33060 > 10.2.224.182.8700: S 1972343059:1972343059(0) win 5840 <mss 1460,sackOK,timestamp 225781001 0,nop,wscale 2> (DF)
> > 11:29:54.983334 10.2.224.182.8700 > 10.2.20.246.33060: S 2770690746:2770690746(0) ack 1972343060 win 33304 <nop,nop,timestamp 99687881 225781001,mss 1460,nop,wscale 1,nop,nop,sackOK> (DF)
> 
> Since the TCP Window Scale options are exchanged,
> the window size field contains shifted value except SYNs.

Be careful, tcpdump may be tracking the window scale and reporting
scaled values.  Seems unlikely since with a window scale of 2, and odd
window size would be impossible.  Also, is there by any chance a busted
firewall in the way (like OpenBSD) that corrupts window scaling. 
