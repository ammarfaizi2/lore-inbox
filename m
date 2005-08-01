Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVHAQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVHAQkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVHAQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:40:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261167AbVHAQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:40:35 -0400
Date: Mon, 1 Aug 2005 17:40:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
Message-ID: <20050801174030.C14401@flint.arm.linux.org.uk>
Mail-Followup-To: Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20050729161343.A18249@flint.arm.linux.org.uk> <20050730.124052.104057695.davem@davemloft.net> <tnxzms1c0bf.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <tnxzms1c0bf.fsf@arm.com>; from catalin.marinas@arm.com on Mon, Aug 01, 2005 at 01:24:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 01:24:04PM +0100, Catalin Marinas wrote:
> "David S. Miller" <davem@davemloft.net> wrote:
> > From: Russell King <rmk+lkml@arm.linux.org.uk>
> > Date: Fri, 29 Jul 2005 16:13:43 +0100
> >
> >> My current patch to get this working is below.  The only thing which
> >> really seems to fix the issue is the __flush_dcache_page call in
> >> read_pages() - if I remove this, I get spurious segfaults and illegal
> >> instruction faults.
> >
> > If one cpu stores, does it get picked up in the other cpu's I-cache?
> 
> It only gets picked up by the other CPU's D-cache (which is fully
> coherent between cores). The I-cache needs to be invalidated on each
> CPU.

Are you sure about this requirement?  I see no evidence of it in Harry's
patch set.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
