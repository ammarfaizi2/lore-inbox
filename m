Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270159AbRH1COZ>; Mon, 27 Aug 2001 22:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270168AbRH1COQ>; Mon, 27 Aug 2001 22:14:16 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:29964 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270159AbRH1COA>; Mon, 27 Aug 2001 22:14:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Peter Magnusson <iocc@flashdance.cx>, <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing stuff in 2.4.8-9 broken
Date: Tue, 28 Aug 2001 04:20:56 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33L2.0108280403140.1540-100000@papperstuss.flashdance.cx>
In-Reply-To: <Pine.LNX.4.33L2.0108280403140.1540-100000@papperstuss.flashdance.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010828021416Z16074-32383+1856@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 28, 2001 04:06 am, Peter Magnusson wrote:
> I just wanted to say that the VM balancing stuff in 2.4.8 and 2.4.9 doesnt
> work very well. 2.4.8 and .9 will use 200 Mbyte of my swap after just 6
> hours! I got 512 Mbyte RAM, 256 Mbyte swap.
> 
> I have now switched back to 2.4.7. Uptime 6 days and 11 Mbyte swap used.
> I would prefer if Linux used as little swap as possible. It only gets
> slower.
> 
> (if you want to reply to me send mail to iocc@flashdancejahatjosan.cx
> without jahatjosan.)

Known problem, a patch exists and was applied in 2.4.10-pre1.  Here it is 
again if you want to verify this:

--- ../2.4.9.clean/mm/memory.c	Mon Aug 13 19:16:41 2001
+++ ./mm/memory.c	Sun Aug 19 21:35:26 2001
@@ -1119,6 +1119,7 @@
 			 */
 			return pte_same(*page_table, orig_pte) ? -1 : 1;
 		}
+		SetPageReferenced(page);
 	}
 
 	/*
