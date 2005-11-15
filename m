Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVKOPPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVKOPPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVKOPPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:15:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63395 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932532AbVKOPPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:15:46 -0500
Message-ID: <4379FC75.80704@watson.ibm.com>
Date: Tue, 15 Nov 2005 10:19:17 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
References: <43796596.2010908@watson.ibm.com> <20051114202017.6f8c0327.akpm@osdl.org> <20051115064954.GB31904@logos.cnet>
In-Reply-To: <20051115064954.GB31904@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Mon, Nov 14, 2005 at 08:20:17PM -0800, Andrew Morton wrote:
> 
>>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>
>>>+	*ts = sched_clock();
>>
>>I'm not sure that it's kosher to use sched_clock() for fine-grained
>>timestamping like this.  Ingo had issues with it last time this happened?  
> 
> 
> If the system boots with use_rtc == 0 you're going to get jiffies based
> resolution from sched_clock(). I have a 1GHz Pentium 3 around here which
> does that.

Good point, thanks. This reemphasizes the need for better normalization
at output time.

> Maybe use do_gettimeofday() for such systems?

Perhaps getnstimeofday() so resolution isn't reduced to msec level unnecessarily.
In these patches, userspace takes responsibility for handling wraparound so
delivering a reasonably high-resolution delay data from the kernel is preferable.

> 
> Would be nice to have a sort of per-arch overridable "gettime()" function?
> 

Provided as part of this patch ?


>><too lazy to read all the code> Do you normalise these numbers in some
>>manner before presenting them to userspace?  If so, by what means?



