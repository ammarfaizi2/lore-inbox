Return-Path: <linux-kernel-owner+w=401wt.eu-S964940AbXAJQam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbXAJQam (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXAJQam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 11:30:42 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46158 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964940AbXAJQal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 11:30:41 -0500
Message-ID: <45A51474.3040906@bull.net>
Date: Wed, 10 Jan 2007 17:29:40 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net>  <45A3BFC8.1030104@bull.net> <1168445501.22579.7.camel@imap.mvista.com>
In-Reply-To: <1168445501.22579.7.camel@imap.mvista.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 17:38:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 17:38:46,
	Serialize complete at 10/01/2007 17:38:46
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker a écrit :
> On Tue, 2007-01-09 at 17:16 +0100, Pierre Peiffer wrote:
>> @@ -1358,7 +1366,7 @@ static int futex_unlock_pi(u32 __user *u
>>         struct futex_hash_bucket *hb;
>>         struct futex_q *this, *next;
>>         u32 uval;
>> -       struct list_head *head;
>> +       struct plist_head *head;
>>         union futex_key key;
>>         int ret, attempt = 0;
>>
>> @@ -1409,7 +1417,7 @@ retry_locked:
>>          */
>>         head = &hb->chain;
>>
>> -       list_for_each_entry_safe(this, next, head, list) {
>> +       plist_for_each_entry_safe(this, next, head, list) {
>>                 if (!match_futex (&this->key, &key))
>>                         continue;
>>                 ret = wake_futex_pi(uaddr, uval, this);
> 
> 
> Is this really necessary? The rtmutex will priority sort the waiters
> when you enable priority inheritance. Inside the wake_futex_pi() it
> actually just pulls the new owner off another plist inside the the
> rtmutex structure.

Yes. ... necessary for non-PI-futex (ie "normal" futex)...

As the hash_bucket_list is used and common for both futex and PI-futex, yes, in 
case of PI_futex, the task is queued two times in two plist.

-- 
Pierre
