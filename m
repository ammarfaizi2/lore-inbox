Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUBZGT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbUBZGT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:19:28 -0500
Received: from alt.aurema.com ([203.217.18.57]:29618 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262695AbUBZGT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:19:26 -0500
Message-ID: <403D8FE6.2010905@aurema.com>
Date: Thu, 26 Feb 2004 17:19:18 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>, johnl@aurema.com
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <1077766232.10393.992.camel@cube>
In-Reply-To: <1077766232.10393.992.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> John Lee writes:
> 
> 
>>The usage rates for each task are estimated using Kalman
>>filter techniques, the  estimates being similar to those
>>obtained by taking a running average over twice the filter
>>_response half life_ (see below). However, Kalman filter
>>values are cheaper to compute and don't require the
>>maintenance of historical usage data.
> 
> 
> Linux dearly needs this. Please separate out this part
> of the patch and send it in.

This information can be determined from the SleepAVG: field in the 
/proc/<pid>/status and /proc/<tgid>/task/<pid>/status files by 
subtracting the value there from 100.  Without our patch this value is a 
directly calculated estimated of the task's sleep rate which is 
available because it used by the O(1) scheduler's heuristics.  With our 
patches, it is calculated from our estimate of the task's usage because 
we dispensed with the sleep average calculations as they are no longer 
needed.  We decided to still report sleep average in the status file 
because we were reluctant to alter the contents of such files in case we 
broke user space programs.

> 
> Right now, Linux does not report the recent CPU usage
> of a process. The UNIX standard requires that "ps"
> report this; right now ps substitutes CPU usage over
> the whole lifetime of a process.
> 
> Both per-task and per-process (tid and tgid) numbers
> are needed. Both percent and permill (1/1000) units
> get reported, so don't convert to integer percent.

I think a modification to fs/proc/array.c to make this field a per 
million rather than a percent value would satisfy your needs.  It would 
be a very small change but there would be concerns about breaking 
programs that rely on it being a percentage.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

