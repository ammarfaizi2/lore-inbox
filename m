Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWIGDEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWIGDEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWIGDEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:04:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54233 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030235AbWIGDEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:04:31 -0400
Message-ID: <44FF8C3B.3040505@us.ibm.com>
Date: Wed, 06 Sep 2006 20:04:27 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
References: <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>	<1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com>	<20060901101801.7845bca2.akpm@osdl.org>	<1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>	<20060906124719.GA11868@atrey.karlin.mff.cuni.cz>	<1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>	<20060906153449.GC18281@atrey.karlin.mff.cuni.cz>	<1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>	<20060906162723.GA14345@atrey.karlin.mff.cuni.cz>	<1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>	<20060906172733.GC14345@atrey.karlin.mff.cuni.cz> <20060906191430.7ffcd833.akpm@osdl.org>
In-Reply-To: <20060906191430.7ffcd833.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 6 Sep 2006 19:27:33 +0200
> Jan Kara <jack@suse.cz> wrote:
>
>   
>>   Ugh! Are you sure? For this path the buffer must be attached (only) to
>> the running transaction. But then how the commit code comes to it?
>> Somebody would have to even manage to refile the buffer from the
>> committing transaction to the running one while the buffer is in wbuf[].
>> Could you check whether someone does __journal_refile_buffer() on your
>> marked buffers, please? Or whether we move buffer to BJ_Locked list in
>> the write_out_data: loop? Thanks.
>>     
>
> The ext3-debug patch will help here.  It records, within the bh, the inputs
> from the last 32 BUFFER_TRACE()s which were run against this bh.  If a
> J_ASSERT fails then you get a nice trace of the last 32 "things" which
> happened to this bh, including the bh's state at that transition.  It
> basically tells you everything you need to know to find the bug.
>
> It's worth spending the time to become familiar with it - I used it a lot in
> early ext3 development.
>   

I will try the patch. Unfortunately, adding more debug is causing the 
problem reproduction
difficult.
> I've been unable to reproduce this crash, btw.  Is there some magic
> incantation apat from running `fsx-linux'?
>   
All I do is on a single 1k filesystem, run 4 copies of fsx (on 4 
different files, ofcourse).
I hit the assert anywhere between 10min-2hours.

Thanks,
Badari

