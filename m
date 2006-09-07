Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWIGPIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWIGPIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWIGPIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:08:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:3213 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751789AbWIGPIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:08:07 -0400
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060906172733.GC14345@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>
	 <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com>
	 <20060901101801.7845bca2.akpm@osdl.org>
	 <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906124719.GA11868@atrey.karlin.mff.cuni.cz>
	 <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
	 <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
	 <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906172733.GC14345@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 08:11:17 -0700
Message-Id: <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Ugh! Are you sure? For this path the buffer must be attached (only) to
> the running transaction. But then how the commit code comes to it?
> Somebody would have to even manage to refile the buffer from the
> committing transaction to the running one while the buffer is in wbuf[].
> Could you check whether someone does __journal_refile_buffer() on your
> marked buffers, please? Or whether we move buffer to BJ_Locked list in
> the write_out_data: loop? Thanks.
> 
> 							

I added more debug in __journal_refile_buffer() to see if the marked
buffers are getting refiled. I am able to reproduce the problem,
but I don't see any debug including my original prints. (It looks as 
if none of my debug code exists) - its really confusing. 

I will keep looking and get back to you.

I may try Andrew's buffer debug patch - if I get desperate.

Thanks,
Badari

