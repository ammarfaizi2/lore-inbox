Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292891AbSB0UJV>; Wed, 27 Feb 2002 15:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292924AbSB0UI7>; Wed, 27 Feb 2002 15:08:59 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:4868 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S292923AbSB0UIj>;
	Wed, 27 Feb 2002 15:08:39 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202272008.XAA10326@ms2.inr.ac.ru>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: raghuangadi@yahoo.com (Raghu Angadi)
Date: Wed, 27 Feb 2002 23:08:15 +0300 (MSK)
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020227194620.69620.qmail@web12308.mail.yahoo.com> from "Raghu Angadi" at Feb 27, 2 11:46:20 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> the deletion from _both_ the lists. 

No, it is only for insertion to established hash table.

References from bind hash are not considered as references.
Look, if socket will sit only in bind table nobody ever will see it.
Where is the the reference? :-) It just must _not_ stay in bind hash,
if no other references remained, that's invariant which we should provide
now. If we will fail, we are in troubles.

So, its absence in bind hash must be guaranteed to the time of destruction.
Look at this from another aspect: imagine you increment refcnt when
adding to binding table. OK. So, what does guarantee that bucket
will not remain in bind hash forever? And "it will not" is equivalent
to "refcnt is not useful".

Anyway, I will think on this at night, I am not ready to tell how to
do this right.


> If you want to avoid timewait_kill() getting called twice altogether.

Sorry, I did not understand what do you mean here. It can be called
twice or three times or more. This is impossible to avoid without adding
spinlock to timewait bucket.

Alexey
