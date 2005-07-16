Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVGPPV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVGPPV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVGPPV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:21:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261661AbVGPPVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:21:52 -0400
Date: Sat, 16 Jul 2005 16:21:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Vincent C Jones <vcjones@networkingunlimited.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.13-rc3][PCMCIA] - iounmap: bad address f1d62000
Message-ID: <20050716162144.A1650@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Vincent C Jones <vcjones@networkingunlimited.com>,
	linux-kernel@vger.kernel.org
References: <4qGHl-3Hm-11@gated-at.bofh.it> <20050716144024.14C8E1F3DC@X31.networkingunlimited.com> <20050716151258.GA7819@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050716151258.GA7819@isilmar.linta.de>; from linux@dominikbrodowski.net on Sat, Jul 16, 2005 at 05:12:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 05:12:58PM +0200, Dominik Brodowski wrote:
> Could you send me the output of /proc/iomem on both a working kernel and on
> 2.6.13-rc3-APM, please?

Dominik, I'd suggest looking elsewhere.  The memory regions must be
free to be able to call into readable(), and therefore pccard_validate_cis().

What seems to be happening is that s->ops->set_mem_map in set_cis_map
is returning an error, causing it to free the ioremapped region
multiple times.  Maybe the card has an invalid CIS causing an out
of range card_start to be requested?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
