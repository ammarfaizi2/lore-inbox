Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbULVODy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbULVODy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbULVODy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:03:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36875 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261816AbULVODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:03:53 -0500
Date: Wed, 22 Dec 2004 14:03:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041222140348.A1130@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	matthew@wil.cx
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com> <20041222134423.GA11750@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041222134423.GA11750@infradead.org>; from hch@infradead.org on Wed, Dec 22, 2004 at 01:44:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 01:44:23PM +0000, Christoph Hellwig wrote:
> > I still save off the pci_dev ptrs for all cards found, so I can
> > register with the serial core after probe (is there a better way?).
> > Should I register the driver separately for each card ? That seems a
> > bit overkill.
> 
> You should register them with the serial core in ->probe.

You want to register with the serial core before you register with PCI.
Then add each port when you find it via the PCI driver ->probe method.

Removal is precisely the reverse order - remove each port in ->remove
method first, then unregister from serial core.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
