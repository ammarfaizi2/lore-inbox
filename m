Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUCPXPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUCPXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:15:35 -0500
Received: from alt.aurema.com ([203.217.18.57]:58757 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261797AbUCPXP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:15:27 -0500
Message-ID: <40578A87.8030501@aurema.com>
Date: Wed, 17 Mar 2004 10:15:19 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it> <1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it> <1AaWr-655-7@gated-at.bofh.it> <m3fzc9o7bc.fsf@averell.firstfloor.org> <40569655.2030802@aurema.com> <20040316061611.GA77627@colin2.muc.de>
In-Reply-To: <20040316061611.GA77627@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>So it does and POSIX.1 (_SC_CLK_TCK) compliant as well.  Unfortunately, 
>>the presence of this functionality makes it VERY difficult to understand 
>>why ticks are being converted from HZ==1000 values to HZ=100 values when 
>>they are being exported to user space especially as this conversion 
>>throws away precision.  Can anyone enlighten me?
> 
> 
> There are two different cases here: 
> 
> Timer tick as visible to user space in the minimum delay of select()
> and other kernel functions with timeout. That is what AT_CLKTCK aims at.

Which is a good reason for USER_HZ to be the same as HZ.

> 
> And exports of values with jiffie units in sysctls in /proc. This was in fact i
> always a bug because they should have used ms or s as unit 
> (there are readily usable utility functions to do this for sysctl). Otherwise
> writing documentation becomes quite difficult. But there are already i
> configurations that set or read these values and was not a good idea to 
> subtly and silently break them. Especially since they predate any exporting 
> of HZ to user space. So the the conversion factor was added.
> 
> This is not only obscure sysctls, ps and top are also consumers of such
> jiffies values in /proc
> 

These programs could (and should) use sysconfig(_SC_CLK_TCK) to find out 
how many ticks there are in a second so this does not constitute a good 
reason for USER_HZ not being equal to HZ.

BTW, in ignorance of sysconfig(_SC_CLK_TCK) and because of statements to 
the same effect in Robert Love's book, I had been assuming that this was 
the reason for USER_HZ and HZ not being equal.  But now that I've been 
told about sysconfig(_SC_CLK_TCK) I can see no valid reason.  That 
doesn't mean that there aren't any but the reasons you've advanced 
certainly aren't them.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

