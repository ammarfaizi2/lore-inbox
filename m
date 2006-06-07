Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWFGWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWFGWsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWFGWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:48:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:2188 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932454AbWFGWsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:48:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH[ RTC: Add rtc_year_days() to calculate tm_yday
Date: Wed, 7 Jun 2006 15:48:31 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e67l3v$k2q$1@terminus.zytor.com>
References: <1149704768.20154.95.camel@fuzzie.sanpeople.com> <20060607193311.GH13165@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149720511 20571 127.0.0.1 (7 Jun 2006 22:48:31 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jun 2006 22:48:31 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060607193311.GH13165@flint.arm.linux.org.uk>
By author:    Russell King <rmk+lkml@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> On Wed, Jun 07, 2006 at 08:26:09PM +0200, Andrew Victor wrote:
> > RTC: Add exported function rtc_year_days() to calculate the tm_yday
> > value.
> 
> Is there a good reason for this?  I ask the question because the x86
> /dev/rtc driver says:
> 
>          * Only the values that we read from the RTC are set. We leave
>          * tm_wday, tm_yday and tm_isdst untouched. Note that while the
>          * RTC has RTC_DAY_OF_WEEK, we should usually ignore it, as it is
>          * only updated by the RTC when initially set to a non-zero value.
> 
> So it seems the established modus operandi for RTC interfaces is "don't
> trust wday, yday and isdst".
> 

"Be conservative in what you send, liberal in what you accept."

	- Mr. Protocol

In this case it seems a good idea to set these fields correctly, but
not rely upon them, unless there are known cases where that causes
trouble.

	-hpa
