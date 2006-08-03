Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWHCOY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWHCOY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWHCOY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:24:28 -0400
Received: from kanga.kvack.org ([66.96.29.28]:34488 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932508AbWHCOY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:24:27 -0400
Date: Thu, 3 Aug 2006 10:24:12 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803142412.GA14997@kvack.org>
References: <44D1FEB7.2050703@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D1FEB7.2050703@arndnet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:48:39PM +0200, Arnd Hannemann wrote:
> However the box is a VIA Epia MII12000 with 1 GB of Ram and 1 GB of swap
> enabled, so there should be plenty of memory available. HIGHMEM support
> is off. The e1000 nic seems to be an 82540EM, which to my knowledge
> should support jumboframes.

> However I can't always reproduce this on a freshly booted system, so
> someone else may be the culprit and leaking pages?
> 
> Any ideas how to debug this?

This is memory fragmentation, and all you can do is work around it until 
the e1000 driver is changed to split jumbo frames up on rx.  Here are a 
few ideas that should improve things for you:

	- switch to a 2GB/2GB split to recover the memory lost to highmem
	  (see Processor Type and Features / Memory split)
	- increase /proc/sys/vm/min_free_kbytes -- more free memory will 
	  improve the odds that enough unfragmented memory is available for 
	  incoming network packets

I hope this helps.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
