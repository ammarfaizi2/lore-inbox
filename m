Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUI3HD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUI3HD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269096AbUI3HD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:03:27 -0400
Received: from ozlabs.org ([203.10.76.45]:11212 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269090AbUI3HDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:03:15 -0400
Date: Thu, 30 Sep 2004 17:01:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930070151.GG21889@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, Olaf Hering <olh@suse.de>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de> <20040930064037.GA3167@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930064037.GA3167@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 04:40:37PM +1000, Anton Blanchard wrote:
>  
> > This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> > Hangs after 'returning from prom_init', wants a power cycle.
> 
> How much memory do you have? We might be filling up a hpte bucket
> completely with certain amounts of memory.

Bugger, bugger, bugger bugger.  That's it.  Just ran 4GB linear
mapping with 4k pages through by hash scattering simulator - max
bucket load is 2 with the old algo and 16 with the new one.  Well, we
just found the first case where the new algorithm scatters
significantly worse than the old one.  It would be something this
dire, wouldn't it.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
