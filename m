Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266125AbTIKGGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbTIKGGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:06:24 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:39907 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S266125AbTIKGGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:06:22 -0400
Date: Thu, 11 Sep 2003 16:06:29 +1000
From: CaT <cat@zip.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030911060629.GA561@zip.com.au>
References: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 05:38:53PM -0700, Patrick Mochel wrote:
> A patch against 2.6.0-test5 can be found at 
> 
> 	http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm1.diff.bz2
> 
> The patches for each individual changeset can be found in that directory. 

Here's my experience with the patch for the various suspend levels (all
activated through /sys/power/state). It looks like there are problems
activating the resume code.

standby:

never turns off screen. just seems to hang after hwsleep-0257. power light
flashes. hitting power button causes power light to stop flashing but no
resume happens. system is hung and powercycle req.

serial console output:

Stopping tasks: ===================================|
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
 hwsleep-0257 [15] acpi_enter_sleep_state: Entering sleep state [S1]

mem:

does stopping tasks and laptop powers down. power light flashes as if in
suspend.

serial console output:

Stopping tasks: =================================|

hand typed continued console out:

hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
 hwsleep-0257 [15] acpi_enter_sleep_state: Entering sleep state [S3]

On resume it is as for standby.

disk (firmware):
activates h/w suspend just fine. bios appears to resume properly (all progress
meters hit 100%) but it never seems to pass control back to the OS (or, at
least, the OS never completes the resume as per above situations)

serial console output:

Stopping tasks: =================================|
Freeing memory: ....................|
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
