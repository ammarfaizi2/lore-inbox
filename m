Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUJHDQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUJHDQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUJHDPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:15:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:55481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267487AbUJHDID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:08:03 -0400
Date: Thu, 7 Oct 2004 20:01:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: chrisw@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007200109.57ce24ae.akpm@osdl.org>
In-Reply-To: <4165FF7B.1070302@cyberone.com.au>
References: <20041007142019.D2441@build.pdx.osdl.net>
	<20041007164044.23bac609.akpm@osdl.org>
	<4165E0A7.7080305@yahoo.com.au>
	<20041007174242.3dd6facd.akpm@osdl.org>
	<20041007184134.S2357@build.pdx.osdl.net>
	<20041007185131.T2357@build.pdx.osdl.net>
	<20041007185352.60e07b2f.akpm@osdl.org>
	<4165FF7B.1070302@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >Chris Wright <chrisw@osdl.org> wrote:
>  >
>  >>(whereas I could get the mainline code, and the
>  >> one-liner to spin right off).  
>  >>
>  >
>  >How?  (up to and including .config please).
>  >
>  >
>  >
> 
>  Ah, free_pages <= pages_high, ie. 0 <= 0, which is true;
>  commence spinning.

Maybe.  It requires that the zonelists be screwy:

 Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
 protections[]: 0 0 0
 Node 1 Normal free:25272kB min:1020kB low:2040kB high:3060kB active:624172kB inactive:282700kB present:1047936kB
 protections[]: 0 0 0
 Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
 protections[]: 0 0 0
 Node 0 DMA free:728kB min:12kB low:24kB high:36kB active:788kB inactive:7848kB present:16384kB
 protections[]: 0 0 0
 Node 0 Normal free:27200kB min:1004kB low:2008kB high:3012kB active:332792kB inactive:422744kB present:1032188kB
 protections[]: 0 0 0
 Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
 protections[]: 0 0 0

See that DMA zone on node 1?  Wonder how it got like that.  It
should not be inside pgdat->nrzones anyway.

David, is your setup NUMA?  Can you show us a sysrq-M dump?

