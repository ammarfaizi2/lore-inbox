Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbUKQKHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUKQKHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbUKQKHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:07:48 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15489 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S262257AbUKQKHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:07:43 -0500
Date: Wed, 17 Nov 2004 11:07:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com
Subject: Re: [PATCH] PNP support for i8042 driver
Message-ID: <20041117100745.GA1387@ucw.cz>
References: <41960AE9.8090409@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41960AE9.8090409@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 02:23:53PM +0100, matthieu castet wrote:
> Hi,
> this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
> is try before the pnp driver so if you don't disable ACPI or apply 
> others pnpacpi patches, it won't change anything.
> 
> Please review it and apply if possible

Ok, my thoughts on this:

	It's OK to keep the device allocated to this driver via the PnP
        subsystem, and not bother with releasing the code via
	__initcall.

	I agree that if there is a way to enumerate the device, (like
	PnP, ACPI or OpenFirmware), we should use that instead of
	probing and using a platform device for the controller.

	I think that we should drop the ACPI support from i8042, in
	favor of pnpacpi, because PnP is more generic and if the
 	keyboard device was listed in PnPBIOS instead of ACPI, it'll
	still work.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
