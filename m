Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUHWVhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUHWVhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUHWVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:32:08 -0400
Received: from mail.tmr.com ([216.238.38.203]:48143 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268017AbUHWVaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:30:02 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: SMP cpu deep sleep
Date: Mon, 23 Aug 2004 17:30:29 -0400
Organization: TMR Associates, Inc
Message-ID: <cgdn8t$l27$1@gatekeeper.tmr.com>
References: <1092989207.18275.14.camel@linux.local> <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093296221 21575 192.168.12.100 (23 Aug 2004 21:23:41 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wes Felter wrote:

> I worked on this last year (I call it CPU packing, because the idea is to
> pack the load onto the fewest number of CPUs).
> 
> The CPU hotplug patch is the way to go, but the hardware is the problem. I
> talked to an Intel CPU architect at MICRO last year and he confirmed that
> SMP Intel systems don't support any low-power modes besides HLT. AMD's
> documentation says that Opterons support voltage/frequency scaling (aka
> Cool 'n' Quiet), but AFAICT the documentation is wrong. In summary, you
> are doomed.
> 

For power saving, HLT is hard to beat ;-) You note HLT as if there was 
some good reason not to use it... Mask everything except some BACK2WORK 
int from the night watchman CPU. I would really like this on some 
machines which seem to leave all CPUs generating heat even when booted 
with a uni kernel.

Whilst thinking about this, *if* using HLT is practical in therms of 
power saving, perhaps all but the last CPU could HLT if the run queue 
was empty, and only be awakened by the "last" CPU, in some case where 
the run queue length was longer than {some_value}.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
