Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262938AbSJBC7B>; Tue, 1 Oct 2002 22:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262940AbSJBC7B>; Tue, 1 Oct 2002 22:59:01 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:17933 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262938AbSJBC67>; Tue, 1 Oct 2002 22:58:59 -0400
Date: Wed, 2 Oct 2002 05:04:22 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.39 + evms 1.2.0 burn test
Message-ID: <20021002030422.GA2127@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK,

I finally got around to take vanilla 2.5.39, put the two EVMS 1.2.0
kernel patches in, compile the lot and here we go. DC-390 breakage will
be a showstopper for some machines, and some other things need to catch
up as well. Regressions over 2.4.19 below (1-7), further info items
8-10:

1. Tekram DC-390 and DC-390T adaptors are broken. Both drivers, AM53C974
   as well as Kurt Garloff's DC-390(T), aka tmscsim, break at compile
   time, telling me to look at the Documentation/blah-DMA-mumble.

2. inter-mezzo: does not compile.

3. frame buffer: I did not bother to figure which frame buffer drivers
   are broken, but disabled all of them.

4. legacy CD-ROM: mcdx (module) cannot be loaded, missing symbol:
   devfs_unregister_blkdev

5. usb: usbkbd (module) cannot be loaded, missing symbol:
   usb_kbd_free_buffers.

6. netfilter: ipt_owner and ip6t_owner (module) cannot be loaded,
   missing symbols: next_thread and find_task_by_pid

7. The LVM->EVMS transition takes some efford (vi /etc/fstab), which I
   cannot afford ATM, hopefully later. Manually mounting the LVM partitions
   with EVMS 1.2.0 and reading from them is fine though.

8. AIC7XXX seems to be fine with my 2940UW Pro.

9. IO-APIC seems to work (doesn't freeze right away as it does for me in
   2.4.X ever since some 2.4.9ac10 or something, I reported that at that
   time but Alan refused to look into this regression and told me it was
   the board's fault.)

10. I enabled ACPI and APM. Lotsa messages, too fast to read, more than
    dmesg holds, and no serial console at hand to save them, but I did
    not see complaints.

IDE (VIA chip set here) wrote "DMA disabled" at kernel boot (scan
hardware) time, but hdparm later claimed DMA was actually enabled, and
the hdparm -tT figures indeed rather looked rather like UDMA66 (IBM
DTLA-307045: 35.57 MB/s, other drives with proper figures as well).  The
dmesg seems not to tell me when DMA was reenabled, but this seems to be
a cosmetic issue.

Notably, EVMS user-space (evmsn) complained about my ReiserFS-progs
3.6.4-pre2 although these seem to be the best reiserfsprogs version
around at this time, previous reiserfsck versions missed some snares and
left them unfixed. evmsn also complained about my JFS and XFS tools
(SuSE Linux 7.3 packages), but I don't bother to check this right now.

Other than that, I'll have to do more testing as my time permits.

-- 
Matthias Andree
