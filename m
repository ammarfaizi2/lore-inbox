Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267695AbUHEPaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267695AbUHEPaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHEPaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:30:18 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:44294 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267695AbUHEPaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:30:10 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Hector Martin <hector@marcansoft.com>, Pasi Sjoholm <ptsjohol@cc.jyu.fi>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
References: <Pine.LNX.4.44.0408041915510.14609-100000@silmu.st.jyu.fi>
	<41120882.40302@marcansoft.com> <41121237.4050305@marcansoft.com>
	<20040805132233.A7430@electric-eye.fr.zoreil.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 06 Aug 2004 00:28:40 +0900
In-Reply-To: <20040805132233.A7430@electric-eye.fr.zoreil.com>
Message-ID: <871xiltxhz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> writes:

> Hector Martin <hector@marcansoft.com> :
> [...]
> > using a stabler TCP/IP stack. This one works OK. No problem so far... 
> > anyway, even though it stopped and I had to restart the PS2 some times, 
> > the PC has been receiving packets with no reboot whatsoever. I think 
> > it's fixed :)
> 
> Ok, I'll send the final version of the patches for inclusion in -netdev
> and/or -mm this evening. It will provide a broader testing.

Bit interesting.

On the final analysis, what was the cause of this problem?
I found the following in progguide-8100(100).pdf. Does this help something?

2.5 Software Issues

This section covers the handling of various data reception topics.

    1. Handling a Receive Buffer Overflow:
       The Rx DMA (FIFO to buffer) is stopped. The CAPR must be
       updated first to dismiss the ISR (RxBufferOverflow) event. The
       correct actions to process RxBufOvw are:
           a. Update CAPR.
           b. Write a 1 to ISR (ROK).
       The Rx DMA resumes after step b.

    2. Handling RxFIFOOvw:
       When RxFIFOOvw occurs, all incoming packets are discarded.
       Clearing ISR (RxFIFOOvw) doesn t dismiss the RxFIFOOvw event.
       To dismiss the RxFIFOOvw event, the ISR (RxBufOvw) must be
       written with a 1.

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
