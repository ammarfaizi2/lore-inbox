Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbULFJNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbULFJNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbULFJNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:13:33 -0500
Received: from fmr19.intel.com ([134.134.136.18]:8352 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261430AbULFJN1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:13:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] Strange code in cpu_idle()
Date: Mon, 6 Dec 2004 17:13:12 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575B63AA3@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Strange code in cpu_idle()
Thread-Index: AcTbIBDMFncsFceqQVWCd1EKxzGKTQAU0BfA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <paulmck@us.ibm.com>, <sfr@canb.auug.org.au>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Dec 2004 09:13:13.0647 (UTC) FILETIME=[D05993F0:01C4DB73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>static void __exit apm_exit(void)
>{
>	int	error;
>
>	if (set_pm_idle) {
>		pm_idle = original_pm_idle;
>		/*
>		 * We are about to unload the current idle thread pm
callback
>		 * (pm_idle), Wait for all processors to update
cached/local
>		 * copies of pm_idle before proceeding.
>		 */
>		synchronize_kernel();
>	}
This patch is written by me. The detail information is in
http://bugzilla.kernel.org/show_bug.cgi?id=1716


>Unfortunately, the idle loop is a quiescent state, so it is
>possible for synchronize_kernel() to return before the idle threads
>have returned.  So I don't believe RCU is useful here.  One other
>approach would be to keep a cpu mask, in which apm_exit() sets all
>bits, and pm_idle() clears its CPU's bit only if it is set.
>Then apm_exit() could wait for all CPU's bits to clear.
This is my original idea. We think it's too complex, so we discard it.
Sorry for my bad.

Thanks,
Shaohua
