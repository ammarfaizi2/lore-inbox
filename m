Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWEMPpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWEMPpD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWEMPpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:45:03 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:48818 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932451AbWEMPpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:45:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=08ZqmCd+Z2eN1VlDtUYgsjubengzQJ6lMKrSsSE5gtgqKMvO4AjwOvO7COSVJCrGGJxVtbZGl423jyRsGNKTRMYvNVPGTuMiARy7OhygsB8cGM1ukLNDDE4uUJYZWrz4H0f9cuP+shcLbQnKka+tuYjHVy2w3mQd3at3ZvosxSA=  ;
Message-ID: <4465FEFD.9050603@yahoo.com.au>
Date: Sun, 14 May 2006 01:45:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>	<20060512091451.GA18145@elte.hu>	<4465386B.9090804@yahoo.com.au>	<Pine.LNX.4.58.0605131010110.27003@gandalf.stny.rr.com> <s5hpsiivsw8.wl%tiwai@suse.de>
In-Reply-To: <s5hpsiivsw8.wl%tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Sat, 13 May 2006 10:12:11 -0400 (EDT),
> Steven Rostedt wrote:
> 
>>
>>Index: linux-2.6.17-rc3-mm1/kernel/sched.c
>>===================================================================
>>--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-12 04:02:32.000000000 -0400
>>+++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-13 10:09:15.000000000 -0400
>>@@ -192,6 +192,10 @@ static inline unsigned int task_timeslic
>>  * These are the runqueue data structures:
>>  */
>>
>>+/*
>>+ * Calculate BITMAP_SIZE.
>>+ *  The bitmask holds MAX_PRIO bits + 1 for the delimiter.
>>+ */
>> #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
> 
> 
> What's wrong with BITS_TO_LONG(MAX_PRIO + 1) ?
> 
> Or, using DECLARE_BITMAP() in struct prio_array would be easier...

Yes that sounds even better.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
