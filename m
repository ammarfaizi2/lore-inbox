Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbUCPIEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbUCPIDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:03:11 -0500
Received: from colin2.muc.de ([193.149.48.15]:8964 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263506AbUCPIDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:03:03 -0500
Date: 16 Mar 2004 07:16:12 +0100
Date: Tue, 16 Mar 2004 07:16:12 +0100
From: Andi Kleen <ak@muc.de>
To: Peter Williams <peterw@aurema.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040316061611.GA77627@colin2.muc.de>
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it> <1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it> <1AaWr-655-7@gated-at.bofh.it> <m3fzc9o7bc.fsf@averell.firstfloor.org> <40569655.2030802@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40569655.2030802@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it does and POSIX.1 (_SC_CLK_TCK) compliant as well.  Unfortunately, 
> the presence of this functionality makes it VERY difficult to understand 
> why ticks are being converted from HZ==1000 values to HZ=100 values when 
> they are being exported to user space especially as this conversion 
> throws away precision.  Can anyone enlighten me?

There are two different cases here: 

Timer tick as visible to user space in the minimum delay of select()
and other kernel functions with timeout. That is what AT_CLKTCK aims at.

And exports of values with jiffie units in sysctls in /proc. This was in fact i
always a bug because they should have used ms or s as unit 
(there are readily usable utility functions to do this for sysctl). Otherwise
writing documentation becomes quite difficult. But there are already i
configurations that set or read these values and was not a good idea to 
subtly and silently break them. Especially since they predate any exporting 
of HZ to user space. So the the conversion factor was added.

This is not only obscure sysctls, ps and top are also consumers of such
jiffies values in /proc

-Andi

