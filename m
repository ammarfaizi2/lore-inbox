Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUBZIMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbUBZIMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:12:12 -0500
Received: from fmr11.intel.com ([192.55.52.31]:36762 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262730AbUBZIMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:12:09 -0500
Subject: Re: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
From: Len Brown <len.brown@intel.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Elliot Mackenzie <macka@adixein.com>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F32F8@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F32F8@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077783113.22401.69.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Feb 2004 03:11:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bootflag.c should not use its own private ACPI table parser/mapper --
this is a bug:

http://bugme.osdl.org/show_bug.cgi?id=1922

Elliot,
If you add your system info to that bug report and volunteer to help
test the fix, I'll be delighted to use your system as an excuse to
address this issue promptly.

thanks,
-Len

ps.
The reason you enter diag mode when SBF is disabled is because w/o SBF,
the BOOTING flag doesn't get cleared, so the BIOS assumes the system
didn't boot correctly and when entered next it is in DIAG mode.  This is
expected.

IMO, module load time is probably too early to clear the BOOTING flag
anyway.  It should be cleared upon completion of successful boot --
though I'm not sure how to identify that point.  Come to think about it,
maybe we should delay clearing the BOOTING flag until Linux initiates a
graceful shutdown, sleep, or reboot?  If the system died b/c of bad RAM
or something, that would make it run through DIAGS when it next enters
POST.


