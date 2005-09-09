Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVIIRtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVIIRtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVIIRtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:49:51 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:5328 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1030288AbVIIRtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:49:50 -0400
Message-ID: <4321CB39.3080206@lanl.gov>
Date: Fri, 09 Sep 2005 11:49:45 -0600
From: Josip Loncaric <josip@lanl.gov>
Organization: LANL
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org
Subject: PROBLEM: sk98lin misbehaves with D-Link DGE-530T which doesn't have
 readable VPD
References: <42EE9721.5000501@lanl.gov>
In-Reply-To: <42EE9721.5000501@lanl.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver sk98lin makes repeated attempts to read VPD even after the first 
VpdInit() fails.  This is wrong.

Lots of people seem to be getting repeated "Vpd: Cannot read VPD keys" 
errors.  When nifd is active, this can happen every second, causing 
kernel stalls that disrupt time-critical operations (e.g. DVD use).

Inexpensive cards like D-Link DGE-530T may lack a readable VPD, so there 
is no point in trying to access this missing feature and causing brief 
system stalls (see 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=136158).

Can sk98lin be enhanced to give up on VPD after the first VpdInit() 
fails?  The NIC appears to operate stably even without a readable VPD.

I haven't tested the experimental driver skge, but the same comment may 
apply.  Obviously it makes no sense to repeatedly look for VPD keys when 
the VPD is missing or incorrect.

Sincerely,
Josip
