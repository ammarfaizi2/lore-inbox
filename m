Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDVALl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDVALl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDVALl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:11:41 -0400
Received: from gate.ebshome.net ([64.81.67.12]:36030 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S1750776AbWDVALl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:11:41 -0400
Date: Fri, 21 Apr 2006 17:11:40 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2]: Spider ethernet driver -- protect chain head
Message-ID: <20060422001140.GA12826@gate.ebshome.net>
Mail-Followup-To: Linas Vepstas <linas@austin.ibm.com>,
	utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20060421232942.GG7242@austin.ibm.com> <20060421234551.GI7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421234551.GI7242@austin.ibm.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 06:45:51PM -0500, Linas Vepstas wrote:
> Prevent a potential race. If two threads are both calling
> the transmit routine, both can potentially try to grab the
> same dma descriptor. Serialize access to the head of the
> tx ring with spinlocks.

Two threads cannot be in spider_net_xmit() simultaneosuly because 
hard_start_xmit entry point is already protected by net_device 
xmit_lock, see Documentation/net/netdevices.txt

-- 
Eugene

