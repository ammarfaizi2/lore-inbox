Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUHFKn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUHFKn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268122AbUHFKn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:43:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267818AbUHFKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:43:25 -0400
Date: Fri, 6 Aug 2004 11:43:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de, akpm@osdl.org,
       rml@ximian.com, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] pcmcia driver model support [4/5]
Message-ID: <20040806114320.A13653@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de,
	akpm@osdl.org, rml@ximian.com, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org
References: <20040805222820.GE11641@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040805222820.GE11641@neo.rr.com>; from ambx1@neo.rr.com on Thu, Aug 05, 2004 at 10:28:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:28:20PM +0000, Adam Belay wrote:
> It is not safe to use the skt_sem in pcmcia_validate_mem.  This patch
> fixes a real world bug, and without it many systems will fail to shutdown
> properly.

However, we need to take this semaphore here to prevent the socket state
changing.  It sounds from your description that we're hitting yet another
stupid recursion bug in PCMCIA...

It sounds like we shouldn't be holding skt_sem when we wait for userspace
to reply to the ejection request.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
