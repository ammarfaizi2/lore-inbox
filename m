Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUJCNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUJCNIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUJCNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 09:08:53 -0400
Received: from [80.227.59.61] ([80.227.59.61]:53145 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S267921AbUJCNIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 09:08:48 -0400
Message-ID: <415FFA57.8040601@0Bits.COM>
Date: Sun, 03 Oct 2004 17:10:47 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Application 0.6+ (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Content-Type: multipart/mixed;
 boundary="------------070903010301060503070306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070903010301060503070306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Ok, here is the kernel messages attached. Nothing of real value in it as 
far as i can see (even with PM_DEBUG on), but you may spot something. 
Basically the suspend process appears to start but the machine is never 
powered off and the resume kernel routines are run immediately bringing 
the kernel/system back to it's resumed state. The *same* kernel config 
works on -rc2. If i hard power off the machine then i have to fsck my 
disks on bootup (as expected) and the suspended image is not loaded.
Clearly the latest patches have broken something but what ? Can anyone 
else without ACPI suspend on -rc3 ?


 > Check your .config to see if it is enabled, and make sure you have
 > resume= on command line. If it still fails, mail me dmesg of failed
 > attempt.

As i keep mentioning, i have a problem with *shutting down* not 
resuming. I'm assuming if a good memory image is written and machine 
powered off correctly i will be able to resume correctly (with the 
recent hihgmem fix). We should be looking at why APM BIOS shutdown 
routine is not working correctly.

My kernel values

% grep -i CONFIG_PM .config
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_STD_PARTITION="/dev/hda2"

/sys/power% cat disk
shutdown
/sys/power% cat state
standby mem disk

To suspend i do

echo -n disk >/sys/power/state

Thanks for any more suggestions
M
-------- Original Message --------
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Sat, 2 Oct 2004 16:22:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mitch  <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org

Hi!

 > I don't understand. The highmem issue was when resuming, not when
 > suspending ? My laptop doesn't suspend with -rc3. Please elaborate ?
 > What config do i change ? Remember i don't have ACPI, so unless pmdisk
 > supports APM BIOS poweroff, then -rc3 is useless to me.

There's no pmdisk in -rc3.

swsusp in -rc3 should support apm.

Check your .config to see if it is enabled, and make sure you have
resume= on command line. If it still fails, mail me dmesg of failed
attempt.

								Pavel

--------------070903010301060503070306
Content-Type: text/plain;
 name="kernellog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernellog.txt"

Oct  3 14:39:19 client kernel: Stopping tasks: =============================================|
Oct  3 14:39:19 client kernel: Freeing memory: .................................................|
Oct  3 14:39:19 client kernel: uhci_hcd 0000:00:1d.2: suspend_hc
Oct  3 14:39:19 client kernel: uhci_hcd 0000:00:1d.1: suspend_hc
Oct  3 14:39:19 client kernel: uhci_hcd 0000:00:1d.0: suspend_hc
Oct  3 14:39:19 client kernel: PM: Attempting to suspend to disk.
Oct  3 14:39:19 client kernel: PM: snapshotting memory.
Oct  3 14:39:19 client kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Oct  3 14:39:19 client kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Oct  3 14:39:19 client kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Oct  3 14:39:19 client kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Oct  3 14:39:19 client kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Oct  3 14:39:19 client kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Oct  3 14:39:21 client kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Oct  3 14:39:21 client kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Oct  3 14:39:21 client kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Oct  3 14:39:21 client kernel: uhci_hcd 0000:00:1d.2: wakeup_hc
Oct  3 14:39:21 client kernel: uhci_hcd 0000:00:1d.0: wakeup_hc
Oct  3 14:39:21 client kernel: Restarting tasks... done

--------------070903010301060503070306--
