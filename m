Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUJ0Csk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUJ0Csk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUJ0Csk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:48:40 -0400
Received: from fmr06.intel.com ([134.134.136.7]:6568 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261595AbUJ0Csd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:48:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fixing MTRR smp breakage and suspending sysdevs.
Date: Wed, 27 Oct 2004 10:48:22 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing MTRR smp breakage and suspending sysdevs.
Thread-Index: AcS7Cahc/wK1SPoBQUuAOiUzkp1TGAAxQq/Q
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <ncunningham@linuxmail.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2004 02:48:24.0049 (UTC) FILETIME=[6D5A8610:01C4BBCF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi!
>
>I've just had a go at fixing the issue with my implementation not
>suspending the sysdevs (I believe swsusp does the same). In the
process,
>I reworked the MTRR support so it's not treated as a sysdev. Instead,
>when we're saving cpu state, the mtrr_save function function is called.
>When we go to restore CPU state, each CPU calls a function that resets
>it's MTRRs and the 'main' cpu then frees the saved data. This is
working
>well here (did a dozen plus suspends on the trot), but I want to check
>that it sounds like the right solution to you.
>
>Perhaps this method should be made more generic? (Are there likely to
be
>other per-cpu state savers needed?)
>
>One thing I have noticed is that by adding the sysdev suspend/resume
>calls, I've gained a few seconds delay. I'll see if I can track down
the
>cause.
Is the problem MTRR resume must be with IRQ enabled, right? Could we
implement a method sysdev resume with IRQ enabled? MTRR driver isn't the
only case. The ACPI Link device is another case, it's a sysdev (it must
resume before any PCI device resumed), but its resume (it uses semaphore
and non-atomic kmalloc) can't invoked with IRQ enabled. I guess cpufreq
driver is another case when suspend/resume SMP is supported.

Thanks,
Shaohua
