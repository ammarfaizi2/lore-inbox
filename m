Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965633AbVKHAa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965633AbVKHAa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965634AbVKHAa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:30:29 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:34424 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965633AbVKHAa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:30:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pIgjG54+F61+98sWtMXy6MIWAjuyJD/9OdEVsixMME8bwaRywyhNjEQDQK++ZBzdTGxBuXPIiDFTTDAdod93BNT8LEXiL6mNbv6YefkfguSdg/7DiQybMTQk6SXy3Zy70tfX4JWyb7fqlBE8PxspGAbKdD8IILj7aBAhCdHU+X4=  ;
Message-ID: <436FF20D.8030200@yahoo.com.au>
Date: Tue, 08 Nov 2005 11:32:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Neil Brown <neilb@suse.de>, dm-devel@redhat.com, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, aherrman@de.ibm.com, bunk@stusta.de,
       cplk@itee.uq.edu.au
Subject: Re: [dm-devel] Re: [PATCH resubmit] do_mount: reduce stack consumption
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>	<20051104084829.714c5dbb.akpm@osdl.org>	<20051104212742.GC9222@osiris.ibm.com>	<20051104235500.GE5368@stusta.de>	<20051104160851.3a7463ff.akpm@osdl.org>	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>	<20051104173721.597bd223.akpm@osdl.org>	<17260.17661.523593.420313@cse.unsw.edu.au>	<17262.40176.342746.634262@cse.unsw.edu.au> <20051107153706.2f3c8b67.akpm@osdl.org>
In-Reply-To: <20051107153706.2f3c8b67.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Neil Brown <neilb@suse.de> wrote:
> 
>>...
>>Reduce stack usage with stacked block devices
>>
>>...
>>diff ./include/linux/sched.h~current~ ./include/linux/sched.h
>>--- ./include/linux/sched.h~current~	2005-11-07 10:01:36.000000000 +1100
>>+++ ./include/linux/sched.h	2005-11-07 10:02:23.000000000 +1100
>>@@ -829,6 +829,9 @@ struct task_struct {
>> /* journalling filesystem info */
>> 	void *journal_info;
>> 
>>+/* stacked block device info */
>>+	struct bio *bio_list, **bio_tail;
>>+
>> /* VM state */
>> 	struct reclaim_state *reclaim_state;
>> 
> 
> 
> More state in the task_strut is a bit sad, but not nearly as sad as deep
> recursion in our deepest codepath..
> 
> Possibly one could do:
> 
> struct make_request_state {
> 	struct bio *bio_list;
> 	struct bio **bio_tail;
> };
> 
> and stick a `struct make_request_state *' into the task_struct and actually
> allocate the thing on the stack.  That's not much nicer though.

Possibly it could go into struct io_context?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
