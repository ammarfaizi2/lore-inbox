Return-Path: <linux-kernel-owner+w=401wt.eu-S1751513AbWLOQjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWLOQjA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbWLOQjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:39:00 -0500
Received: from lw.wurtel.net ([82.192.92.211]:2496 "EHLO lw.wurtel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbWLOQi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:38:59 -0500
X-Greylist: delayed 2465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 11:38:59 EST
Date: Fri, 15 Dec 2006 16:57:47 +0100
From: Paul Slootman <paul+nospam@wurtel.net>
To: linux-kernel@vger.kernel.org
Cc: cw@f00f.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061215155747.GB1519@msgid.wurtel.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, cw@f00f.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cw@f00f.org wrote:
>On Wed, Dec 13, 2006 at 09:11:29PM +0100, Christoph Anton Mitterer wrote:
>
>> - error in the Opteron (memory controller)
>> - error in the Nvidia chipsets
>> - error in the kernel
>
>My guess without further information would be that some, but not all
>BIOSes are doing some work to avoid this.
>
>Does anyone have an amd64 with an nforce4 chipset and >4GB that does
>NOT have this problem?  If so it might be worth chasing the BIOS
>vendors to see what errata they are dealing with.

We have a number of Tyan S2891 systems at work, most with 8GB but all at
least 4GB (data corruption still occurs whether 4 or 8GB is installed;
didn't try less than 4GB...). All have 2 of the following CPUs:
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 37
model name      : AMD Opteron(tm) Processor 248
stepping        : 1
cpu MHz         : 2210.208
cache size      : 1024 KB


- the older models have no problem with data corruption,
  but fail to boot 2.6.18 and up (exactly like
  http://bugzilla.kernel.org/show_bug.cgi?id=7505 )

- the newer models had problems with data corruption (running md5sum
  over a large number of files would show differences from run to run).
  Sometimes the system would hang (no messages on the serial console,
  no magic sysrq, nothing).
  These have no problem booting 2.6.18 and up, however.
  These were delivered with a 2.02 BIOS version.
  On a whim I tried booting with "nosmp noapic", and running on one CPU
  the systems seemed stable, no data corruption and no crashes.

- The older models flashed to the latest 2.02 BIOS from the Tyan website
  still have no data corruption but still won't boot 2.6.18 and up.

- The newer models flashed (downgraded!) to the 2.01 BIOS available from the Tyan
  website seem to work fine, no data corruption while running on both
  CPUs and no crashes (although perhaps time is too short to tell for
  sure, first one I did was 10 days ago).

- I have an idea that perhaps the 2.02 BIOS the newer systems were
  delivered with is a subtely different version than the one on the
  website. I may try flashing 2.02 again once the current 2.01 on these
  systems has proven to be stable.

- Apparently there's something different on the motherboards from the
  first batch and the second batch, otherwise I couldn't explain the
  difference in ability to boot 2.6.18 and up. However, I haven't had an
  opportunity to open two systems up to compare them visually.



Paul Slootman
