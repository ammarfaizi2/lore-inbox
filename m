Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSFEURV>; Wed, 5 Jun 2002 16:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSFEURU>; Wed, 5 Jun 2002 16:17:20 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9120 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316213AbSFEURT>;
	Wed, 5 Jun 2002 16:17:19 -0400
Date: Sun, 2 Jun 2002 02:00:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device model documentation 2/3
Message-ID: <20020602020040.D47@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206040918490.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	int 	(*remove)	(struct device * dev);
> 
> remove is called to dissociate a driver with a device. This may be
> called if a device is physically removed from the system, if the
> driver module is being unloaded, or during a reboot sequence. 
> 
> It is up to the driver to determine if the device is present or
> not. It should free any resources allocated specifically for the
> device; i.e. anything in the device's driver_data field. 
> 
> If the device is still present, it should quiesce the device and place
> it into a supported low-power state.

"returns 0 == success or error code, and may block."

> 	int	(*suspend)	(struct device * dev, u32 state, u32 level);
> 
> suspend is called to put the device in a low power state. There are
> several stages to sucessfully suspending a device, which is denoted in
> the @level parameter. Breaking the suspend transition into several
> stages affords the platform flexibility in performing device power
> management based on the requirements of the system and the
> user-defined policy.

"returns 0 == success or error code"

> SUSPEND_NOTIFY notifies the device that a suspend transition is about
> to happen. This happens on system power state transition to verify
> that all devices can sucessfully suspend.
> 
> A driver may choose to fail on this call, which should cause the
> entire suspend transition to fail. A driver should fail only if it
> knows that the device will not be able to be resumed properly when the
> system wakes up again. It could also fail if it somehow determines it
> is in the middle of an operation too important to stop.

??? If it is in the middle of important operation, it should just yield()
waiting for operation to finish.

> SUSPEND_DISABLE tells the device to stop I/O transactions. When it
> stops transactions, or what it should do with unfinished transactions
> is a policy of the driver. After this call, the driver should not
> accept any other I/O requests.

I believe higher levels should make it so that no new requests are submitted.
We do not want each and every driver to implement its own (buggy!) method for
this.

									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

