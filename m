Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272675AbTHFWPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272912AbTHFWPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:15:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33036 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272675AbTHFWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:15:22 -0400
Date: Wed, 6 Aug 2003 23:15:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2: unable to suspend (APM)
Message-ID: <20030806231519.H16116@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to test out APM on my laptop (in order to test some PCMCIA
changes), but I'm hitting a brick wall.  I've added the device_suspend()
calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
calls into apm's suspend() function.  (this is needed so that PCI
devices receive their notifications.)

However, APM is refusing to suspend.  I'm seeing the following kernel
messages:

Suspending devices
hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
Suspending devices
Suspending devices
apm: suspend: Unable to enter requested state
Devices Resumed
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue c03a845c, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
hdb: completing PM request, resume
Devices Resumed
Devices Resumed

The "apm: suspend: Unable to enter requested state" occurs about 20
seconds afterwards.

(Note that APM worked fine with 2.2 and 2.4 kernels.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

