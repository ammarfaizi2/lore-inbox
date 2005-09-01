Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVIAUqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVIAUqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIAUqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:46:05 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:27771 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030331AbVIAUqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:46:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=FnGq+79qgSZ5exHguoeLyabxqlRsXN6x02vlvaIxabyrNJZR/aLPT0q7luskrEl2a3tcfemh8vlwf+z5ftxKciicwNCtJ7PemTf9HkBvyIgrrHinCXfHJZ6mKo/NccJJFni4a1Gx9iYX/jvE7AEQ+xPIMJ5yT4fxj15FWLViUHE=  ;
Message-ID: <43176820.5060609@yahoo.co.uk>
Date: Thu, 01 Sep 2005 21:44:16 +0100
From: Richard Hayden <rahaydenuk@yahoo.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050228)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: coywolf@gmail.com
Subject: A couple of OOM killer races
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It appears there is no protection in badness() (called by 
out_of_memory() for each process) when it reads p->mm->total_vm. Another 
processor (or a kernel preemption) could presumably run do_exit and then 
exit_mm, freeing the process in question's reference to its mm just 
after the (!p->mm) check but before it reads p->mm->total_vm, making the 
latter reference a null pointer reference.

Also there appears to be no protection when we set p->time_slice in 
__oom_kill_task(). Am I right in thinking that this field should be 
protected by the appropriate runqueue lock, at least this is what 
scheduler_tick() seems to use?

Have I missed anything?

Best regards,

Richard Hayden.

		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
