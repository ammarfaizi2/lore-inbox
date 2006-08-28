Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWH1Qfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWH1Qfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWH1Qfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:35:33 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:65260 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751149AbWH1Qfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:35:33 -0400
Date: Mon, 28 Aug 2006 18:35:31 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       jesse.barnes@intel.com, dwalker@mvista.com
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
Message-ID: <20060828163531.GA8257@rhlx01.fht-esslingen.de>
References: <1156780080.3034.207.camel@laptopd505.fenrus.org> <20060828161145.GA25161@rhlx01.fht-esslingen.de> <44F3178F.8010508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F3178F.8010508@linux.intel.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 28, 2006 at 06:19:27PM +0200, Arjan van de Ven wrote:
> I could have sworn there was an idle call notifier already\
> 
> ah there is on x86-64 but it is architecture specific...

So we would already have something that could be extended.

BTW, my IRQ statement was misplaced since this is the very thing we're
caring about: de-idle activation latency right after hardware IRQ occurred.
IOW, an idle callback really could be useful, since it does
positively work against the buffer servicing IRQ wakeup latency issue.

Another question is how one would do callback processing in idle handler:
one could figure out the idle mode (latency) in advance and *then* call
only all those idle callbacks that have more stringent requirements
than the currently calculated idle mode's latency (and then calculate
the idle mode again based on the current time after all those callbacks??),
or one could just unconditionally call all idle handlers and then figure out
idle length and go to sleep. Which one is better?

Andreas Mohr
