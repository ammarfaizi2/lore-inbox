Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269443AbUJSPIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269443AbUJSPIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUJSPIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:08:06 -0400
Received: from mail.tmr.com ([216.238.38.203]:60420 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269443AbUJSPHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:07:34 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: per-process shared information
Date: Tue, 19 Oct 2004 11:09:46 -0400
Organization: TMR Associates, Inc
Message-ID: <cl3a4l$pmt$1@gatekeeper.tmr.com>
References: <1097846353.2674.13298.camel@cube><1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098197973 26333 192.168.12.100 (19 Oct 2004 14:59:33 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20041015162000.GB17849@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Oct 15, 2004 at 09:19:13AM -0400, Albert Cahalan wrote:
> 
>>I don't see why it is such trouble to provide the old data.
> 
> 
> I agree with you w.r.t. binary compatibility, here it's even a "source
> compatibility" matter, a recompile wouldn't fix it.
> 
> However I wasn't exactly advocating to keep it 100% backwards
> compatible in this case: somebody already broke it from 2.5.x to
> 2.6.9-rc, and since there was a very good reason for that, we should
> probably declare it broken.  Here there has been a very strong technical
> reason to break statm, but they didn't break binary and source
> compatibility gratuitously like some solaris kernel developer seems to
> think in some blog.
> 
> the problem is that when ps xav wants to know the RSS it reads statm,
> so we just cannot hurt ps xav to show the "old shared" information that
> would be extremely slow to collect.
> 
> I was only not happy about dropping the old feature completely instead
> of providing it with a different new API. Now I think the solution Hugh
> just proposed with the anon_rss should mimic the old behaviour well
> enough and it's probably the right way to go, it's still not literally
> the same, but I doubt most people from userspace could notice the
> difference, and most important it provides useful information, which is
> the number of _physical_ pages mapped that aren't anonymous memory, this
> is very valuable info and it's basically the same info that people was
> getting from the old "shared". So I like it.

I think that's clearly the right solution. Going to significant effort 
to produce compatible but incorrect values and/or formats is not 
desirable. I've seen this with users and applications, too, complaining 
that the new output doesn't match the old, even when the old was clearly 
wrong.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
