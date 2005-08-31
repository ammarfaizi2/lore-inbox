Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVHaWGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVHaWGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVHaWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:06:33 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:438 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964861AbVHaWGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:06:32 -0400
Message-ID: <431629C8.8030201@nortel.com>
Date: Wed, 31 Aug 2005 16:06:00 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joe.korty@ccur.com
CC: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
References: <F989B1573A3A644BAB3920FBECA4D25A042B0053@orsmsx407> <43161F03.5090604@nortel.com> <20050831213430.GA11858@tsunami.ccur.com>
In-Reply-To: <20050831213430.GA11858@tsunami.ccur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2005 22:06:03.0098 (UTC) FILETIME=[2D674BA0:01C5AE78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:

> The returned timeout struct has a bit used to mark the value as absolute.  Thus
> the caller treats the returned timeout as a opaque cookie that can be
> reapplied to the next (or more likely, the to-be restarted) timeout.

Okay, endtime is always absolute value of when it should have expired. 
But I think I see a problem with the opaque cookie scheme and repeating 
timeouts.

Suppose I want to wake my application at INTERVAL nanoseconds from now 
on the MONOTONIC clock, then again every INTERVAL nanoseconds after that.

How do I do that with this API?

I can get the first sleep.  Suppose I oversleep by X nanoseconds.  I 
wake, and get an opaque timeout back.  How do I ask for the new wake 
time to be "endtime + INTERVAL"?

Chris
