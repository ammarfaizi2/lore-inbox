Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVKGBKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVKGBKW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 20:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVKGBKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 20:10:22 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:29565 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932396AbVKGBKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 20:10:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KGmC2A41Y43EjE+v2lWcIwgFea638mjGr62XQdPwo5AvOM6QSc7s0tuSsRri678zKcavdoaMjjpIZSFjwCEQNxkkzFcUzrTZHXi3jwn9qkHCv8EZ8OQZP9Nl7crkaZTlHZ8GIUQdxV8IrlzXL3u8dmiMZzhNs7VDMps+uZMvg0Y=  ;
Message-ID: <436EA9F9.4020809@yahoo.com.au>
Date: Mon, 07 Nov 2005 12:12:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com>	<20051031140459.GA5664@elte.hu> <20051106134945.0e10cb60.akpm@osdl.org>
In-Reply-To: <20051106134945.0e10cb60.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>+static inline int get_task_struct_rcu(struct task_struct *t)
>>+{
>>+	int oldusage;
>>+
>>+	do {
>>+		oldusage = atomic_read(&t->usage);
>>+		if (oldusage == 0) {
>>+			return 0;
>>+		}
>>+	} while (cmpxchg(&t->usage.counter,
>>+		 oldusage, oldusage + 1) != oldusage);
>>+	return 1;
>>+}
> 
> 
> arm (at least) does not implement cmpxchg.
> 

Yes, and using atomic_t.counter in generic code is ugly, albeit
compatible with all current implementations.

> I think Nick is working on patches which implement cmpxchg on all
> architectures?
> 

Yes, it is basically ready to go.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
