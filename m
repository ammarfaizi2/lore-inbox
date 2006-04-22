Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDVBDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDVBDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDVBDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:03:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:47032 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750798AbWDVBDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:03:22 -0400
Date: Fri, 21 Apr 2006 20:03:21 -0500
To: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2]: Spider ethernet driver -- protect chain head
Message-ID: <20060422010321.GO7242@austin.ibm.com>
References: <20060421232942.GG7242@austin.ibm.com> <20060421234551.GI7242@austin.ibm.com> <20060422001140.GA12826@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422001140.GA12826@gate.ebshome.net>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 05:11:40PM -0700, Eugene Surovegin wrote:
> On Fri, Apr 21, 2006 at 06:45:51PM -0500, Linas Vepstas wrote:
> > Prevent a potential race. If two threads are both calling
> > the transmit routine, both can potentially try to grab the
> > same dma descriptor. Serialize access to the head of the
> > tx ring with spinlocks.
> 
> Two threads cannot be in spider_net_xmit() simultaneosuly because 
> hard_start_xmit entry point is already protected by net_device 
> xmit_lock, see Documentation/net/netdevices.txt

Ahh, thank you. I was wondering why I never semmed to see this
this happen in "real life".

--linas
