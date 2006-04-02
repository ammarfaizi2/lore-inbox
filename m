Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWDBFDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWDBFDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWDBFDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:03:00 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:58191 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751465AbWDBFC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:02:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5/JYBN14GU9ZAf/QWcCMMqbjG1zR5N/hCDB1y7d+1yaTVm6Uk0MXk9RI3RgypGDjdLdC0jMUREGhLXbJVeSpq8DrITQpfdSlMYxfHNCMhTorQk6W/iic5GV79TD/ik6BqgXIfmE9TPnTvUbeISVgxyQtppCX6Y84aQz2IgGoDQM=  ;
Message-ID: <442F2A79.1040903@yahoo.com.au>
Date: Sun, 02 Apr 2006 11:35:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 1/4] sched_domain - handle kmalloc failure
References: <20060401185222.GA10591@in.ibm.com>
In-Reply-To: <20060401185222.GA10591@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> Andrew/Nick/Ingo,
> 	Here's a different version of the patch that tries to handle mem
> allocation failures in build_sched_domains by bailing out and cleaning up 
> thus-far allocated memory. The patch has a direct consequence that we disable 
> load balancing completely (even at sibling level) upon *any* memory allocation 
> failure. Is that acceptable?
> 

I guess so. Ideal solution would be to make all required allocations first,
then fail the build_sched_domains and fall back to the old structure. But
I guess that gets pretty complicated.

In reality (and after your patch 2/4), I don't think the page allocator will
ever fail any of these allocations. In that case, would it be simpler just
to add a __GFP_NOFAIL here and forget about it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
