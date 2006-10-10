Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWJJQnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWJJQnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWJJQnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:43:24 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:3326 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030202AbWJJQnW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:43:22 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known
 regressions)
Date: Tue, 10 Oct 2006 11:43:08 -0500
Message-ID: <1449F58C868D8D4E9C72945771150BDF1536EF@SAUSEXMB1.amd.com>
In-Reply-To: <200610101837.10292.christiand59@web.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known
 regressions)
Thread-Index: AcbsiqQuJx2E1lJBRtKnlGhBMpysnAAAAuaQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Christian" <christiand59@web.de>
cc: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 10 Oct 2006 16:43:08.0733 (UTC)
 FILETIME=[2AAE8ED0:01C6EC8B]
X-WSS-ID: 693512161L85492054-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Dienstag, 10. Oktober 2006 16:59 schrieb Langsdorf, Mark:
> > > I have an AMD K8 system and I'm unable to get cpufreq working
> > > with 2.6.19-rc1.
> > > The cpufreq sysfs directory is missing under
> > > /sys/devices/system/cpu/cpu0/.
> > > 2.6.18 works as expected.
> >
> > What error message are you getting from `dmesg | grep power` ?
> 
> dmesg | grep power
> [   17.852383] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual 
> Core Processor 
> 3800+ processors (version 2.00.00)
> [   17.852403] powernow-k8: MP systems not supported by PSB 
> BIOS structure
> [   17.852428] powernow-k8: MP systems not supported by PSB 
> BIOS structure
> 
> Haven't seen this before.

I thought I cleaned that message out in v2.0.

The BIOS failed to supply _PSS objects that Linux could
recognize.  The powernow-k8 driver tried to use a PSB 
table, but MP/dual-core systems can't use PSB tables.  
The driver errored out.

If you can get it to work with 2.6.18 and it doesn't work
with 2.6.19-rc1, the most likely culprit is a change in the
ACPI subsystem.

Can you get decompiled dumps of the DSDT?  See the ACPI
pages on sourceforge if you need instructions. 

-Mark Langsdorf
AMD, Inc.


