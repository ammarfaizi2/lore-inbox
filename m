Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbUK3ABU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUK3ABU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUK3ABU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:01:20 -0500
Received: from hera.kernel.org ([63.209.29.2]:23682 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261870AbUK3ABO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:01:14 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: efficeon and longrun
Date: Tue, 30 Nov 2004 00:01:05 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cogd81$2nt$1@terminus.zytor.com>
References: <16810.26231.936086.930240@metzlerbros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1101772865 2814 127.0.0.1 (30 Nov 2004 00:01:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 30 Nov 2004 00:01:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16810.26231.936086.930240@metzlerbros.de>
By author:    Ralph Metzler <rjkm@metzlerbros.de>
In newsgroup: linux.dev.kernel
> 
> I recently got a Sharp MP70G with a 1.6 GHz efficeon processor 
> and have some questions regarding longrun support. I am using 
> longrun-0.9-15 and kernel 2.6.10-rc2.
> 

longrun-0.9 is hideously out of date, and was never debugged to begin
with.  Given that these days longrun is handled via cpufreq, there
doesn't seem to be much reason for the standalone longrun program.

> In arch/i386/kernel/cpu/proc.c the kernel seems to check bit 3
> for the lrti capability, longrun.c checks bit2. 

Bit 3 is correct.

> Are thermal extensions different on the efficeon compared to the crusoe?
> No matter what I choose (between 0 and 7) the level field in the ATM
> register is always 0. 

You shouldn't muck with it anyway.  And yes, they are different.  The
thermal extensions are handled via ACPI code, so as long as the ACPI
is handled correctly, it shouldn't matter.

> Are there any new efficeon features not yet supported in the kernel or
> the longrun utility? Is there any register information available
> anywhere? I looked on the transmeta pages but did not find anything
> about this.

The algorithms are very different, but it's all under-the-hood stuff
implemented in firmware.

> The BIOS also allows one to select C4 as possible power level,
> /proc/acpi/processor/CPU0/power only offers C1, C2 and C3. 

C4 support (DSX) is pretty keen.

> I ask because under Windows, if nothing is running, the fan will
> stay off. Under Linux it is turning on about every two minutes and
> will then run for about a minute (also with everything turned off, and
> about every daemon shut down).

	-hpa
