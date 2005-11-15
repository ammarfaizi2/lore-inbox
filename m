Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVKOPFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVKOPFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKOPFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:05:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14217 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932344AbVKOPFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:05:05 -0500
Message-ID: <4379FA09.3040807@watson.ibm.com>
Date: Tue, 15 Nov 2005 10:08:57 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
References: <43796596.2010908@watson.ibm.com> <20051114202017.6f8c0327.akpm@osdl.org>
In-Reply-To: <20051114202017.6f8c0327.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
>>+	*ts = sched_clock();
> 
> 
> I'm not sure that it's kosher to use sched_clock() for fine-grained
> timestamping like this.  Ingo had issues with it last time this happened?  
> 
> <too lazy to read all the code> Do you normalise these numbers in some
> manner before presenting them to userspace?  If so, by what means?

The cpu delay data collected by schedstats (which is jiffies based)
is normalized to nanosecs. The timestamps based on sched_clock() are exported
as is. As Marcelo pointed out, thats not good enough since sched_clock() itself
could return jiffie-based resolution.  So some normalization will be needed for
that data as well.



