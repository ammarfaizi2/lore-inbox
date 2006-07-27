Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWG0TpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWG0TpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWG0TpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:45:14 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:29389 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751962AbWG0TpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:45:11 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [patch] Reorganize the cpufreq cpu hotplug locking to not
 be totally bizare
Date: Thu, 27 Jul 2006 14:29:01 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218F19@SAUSEXMB1.amd.com>
In-Reply-To: <20060726141531.A22927@unix-os.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Reorganize the cpufreq cpu hotplug locking to not
 be totally bizare
Thread-Index: Acaw/Hg1M0HOXRPqTrKaTHj9e92TaQAtijuQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Ashok Raj" <ashok.raj@intel.com>
cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 19:29:02.0648 (UTC)
 FILETIME=[EAB23380:01C6B1B2]
X-WSS-ID: 68D7CC740Y8619859-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> before introducing the ugly recursion we did try the 
> preempt_disable() for cpufreq, and it worked for most all 
> governers with preempt_disable(), but powernowk8 called 
> set_cpus_allowed() in the callback path that threw out a 
> scheduling while in atomic BUG().
> 
> http://lkml.org/lkml/2005/10/31/239

Is there some other preferred call we could be making 
instead of set_cpus_allowed() ?  We need to be able to
program the MSRs on that specific core, and as far as
I know, the only way to do that is to guarantee that
we are scheduled on that particular core.  

If there's a better way to hop to a specific core, I'll
gladly rewrite the code in question.

-Mark Langsdorf
AMD, Inc.


