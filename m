Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbVICIQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbVICIQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVICIQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:16:57 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:40941 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S1751395AbVICIQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:16:56 -0400
Subject: Re: 2.6.13-mm1: hangs during boot ...
From: Len Brown <len.brown@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org
In-Reply-To: <43194E3B.2050609@bigpond.net.au>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA063@hdsmsx401.amr.corp.intel.com>
	 <4319403E.4050105@bigpond.net.au>  <43194E3B.2050609@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 04:19:08 -0400
Message-Id: <1125735548.11903.53.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 03:18 -0400, Peter Williams wrote:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/broken-out/git-acpi.patch
> >>

> I am able to confirm that the problem occurs with vanilla 2.5.13 after
> I apply the above patch.

Thanks.

Please then try the latest ACPI patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050902-2.6.13.diff.gz
It should apply to vanilla 2.6.13 with a reject in ia64/Kconfig
that you can ignore.

If this works, then we munged git-acpi.patch in 2.6.13-mm1 somehow.

If this fails, then please confirm it still fails with pnpacpi=off

if it still fails, then please open a bugzilla here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
component=config-interrupts

build the failing kernel with CONFIG_ACPI_DEBUG=y
boot it with "acpi=noirq" and attach the output from
dmesg -s64000
lspci -vv
cat /proc/interrupts
acpidump, available in the latest pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

also include the dmesg -s64000 from the successful
acpi-enabled 2.6.13 boot, along with its /proc/interrupts.

If you have a  serial console and can then capture the
failing console log with "debug", that would be ideal.

Where we got from there will depend what we see...

thanks,
-Len


