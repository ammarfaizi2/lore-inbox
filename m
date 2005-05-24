Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVEXJVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVEXJVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEXJQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:16:43 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:41148 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261822AbVEXJOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:14:24 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091419.AB59CFB86@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:14:19 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id EB669FB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:41 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261257AbVEXFqX (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 01:46:23 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXFqX

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 01:46:23 -0400

Received: from e34.co.us.ibm.com ([32.97.110.132]:6116 "EHLO e34.co.us.ibm.com")

	by vger.kernel.org with ESMTP id S261257AbVEXFqP (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 01:46:15 -0400

Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])

	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j4O5kFcE277036

	for <linux-kernel@vger.kernel.org>; Tue, 24 May 2005 01:46:15 -0400

Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])

	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4O5kFPd178758

	for <linux-kernel@vger.kernel.org>; Mon, 23 May 2005 23:46:15 -0600

Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])

	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j4O5kEh4018369

	for <linux-kernel@vger.kernel.org>; Mon, 23 May 2005 23:46:14 -0600

Received: from snowy.in.ibm.com (snowy.in.ibm.com [9.182.12.251])

	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j4O5k7C8018274;

	Mon, 23 May 2005 23:46:13 -0600

Received: by snowy.in.ibm.com (Postfix, from userid 502)

	id CE61B24A92; Tue, 24 May 2005 11:16:17 +0530 (IST)

Date:	Tue, 24 May 2005 11:16:17 +0530

From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@muc.de>, zwane@arm.linux.org.uk,
	discuss@x86-64.org, shaohua.li@intel.com,
	linux-kernel@vger.kernel.org, rusty@rustycorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64

Message-ID: <20050524054617.GA5510@in.ibm.com>

Reply-To: vatsa@in.ibm.com
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <20050523104046.B8692@unix-os.sc.intel.com>

User-Agent: Mutt/1.4.1i

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



On Mon, May 23, 2005 at 10:40:46AM -0700, Ashok Raj wrote:
> Iam not a 100% sure about above either, if the smp_call_function 
> is started with 3 cpus initially, and 1 just came up, the counts in 
> the smp_call data struct could be set to 3 as a result of the new cpu 
> received this broadcast as well, and we might quit earlier in the wait.

True.

> sending to only relevant cpus removes that ambiquity. 

Or grab the 'call_lock' before setting the upcoming cpu in the online_map.
This should also avoid the race when a CPU is coming online.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

