Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWI2SaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWI2SaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWI2SaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:30:00 -0400
Received: from mail0.lsil.com ([147.145.40.20]:41099 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1422651AbWI2S37 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:29:59 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OOPS] -git8,9:  NULL pointer dereference in mptspi_dv_renegotiate_work
Date: Fri, 29 Sep 2006 12:29:55 -0600
Message-ID: <664A4EBB07F29743873A87CF62C26D7035039A@NAMAIL4.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OOPS] -git8,9:  NULL pointer dereference in mptspi_dv_renegotiate_work
Thread-Index: Acbj6yiHFKfy7GVRQJGnAjTDaaTDpwACNusg
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Bryce Harrington" <bryce@osdl.org>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 29 Sep 2006 18:29:56.0194 (UTC) FILETIME=[43484420:01C6E3F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 29, 2006 11:18 AM, Bryce Harrington wrote:  

> [<ffffffff80484f94>] mpt_HardResetHandler+0xb4/0x12c
> [<ffffffff8048500c>] mpt_timer_expired+0x0/0x24

mpt_timer_expired means most likely we timed out sending 
request for config page from firmware.  The timeout results
in host reset, which results in domain validation being called.
Perhaps the config pages failed before we allocated memory for hd.

Can you enable debug messages in the driver Makefile, for
the line called MPT_DEBUG_CONFIG; that way we can find out which
config page failed.  

There were some changes in scsi_transort_spi.c, that occured
between 2.6.18-git1 and 2.6.18-git2.  I doubt these changes
would of effected this.   Can you determine between which
git version releases did this problem begin occuring?

Also, can you describe your configuration?  Such as which
kind of devices are you usign, and whether if they are U320 devices,
or are their older ones, such as U160.

Eric
