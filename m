Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVCUVPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVCUVPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVCUVNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:13:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62738 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261912AbVCUVKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:10:05 -0500
Date: Mon, 21 Mar 2005 21:09:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
Message-ID: <20050321210948.B17493@flint.arm.linux.org.uk>
Mail-Followup-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain> <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain> <20050321081638.GC2703@pazke> <20050321082228.A22099@flint.arm.linux.org.uk> <Pine.LNX.4.58_heb2.09.0503211336090.6491@localhost.localdomain> <20050321201847.A16069@flint.arm.linux.org.uk> <Pine.LNX.4.58_heb2.09.0503212248010.7910@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58_heb2.09.0503212248010.7910@localhost.localdomain>; from goldberg@phep2.technion.ac.il on Mon, Mar 21, 2005 at 10:57:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 10:57:21PM +0200, Jacques Goldberg wrote:
> 
>    Great, Russell. Now we understand each other.
>    Actually some chip manufacturers are responsible for this mess. Some do
> NOT burn a modem class flag in the hardware, others do.
>    Is it nonsense to imagine that the part of 8250_pci which handles modem
> class become a loadable module?
>    We could then load the "linmodem" driver first, which would not disturb
> use of true modems.

No, that's not a reliable solution.

What it comes back to is that we _need_ driver match priorities, so we
can detect when a more specific driver for the device is loaded (iow
one which matches by vendor+device rather than just class), unbind the
existing driver, and bind the more specific one.

I've been mentioning this need for over a year now (for a different
scenario) and it hasn't particularly been going anywhere.  However,
your case boosts the reason why we need this functionality.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
