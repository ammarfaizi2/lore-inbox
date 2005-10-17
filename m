Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVJQMbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVJQMbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVJQMbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:31:47 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:8716 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932074AbVJQMbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:31:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <435394A1.7000109@cosmosbay.com>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <435394A1.7000109@cosmosbay.com>
X-OriginalArrivalTime: 17 Oct 2005 12:31:33.0420 (UTC) FILETIME=[B54A16C0:01C5D316]
Content-class: urn:content-classes:message
Subject: Re: [RCU problem] was VFS: file-max limit 50044 reached
Date: Mon, 17 Oct 2005 08:31:21 -0400
Message-ID: <Pine.LNX.4.61.0510170828290.16569@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RCU problem] was VFS: file-max limit 50044 reached
Thread-Index: AcXTFrVThFxPxDATRc6FSQnFRWhFUw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Cc: <dipankar@in.ibm.com>, "Jean Delvare" <khali@linux-fr.org>,
       <torvalds@osdl.org>, "Serge Belyshev" <belyshev@depni.sinp.msu.ru>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Manfred Spraul" <manfred@colorfullife.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Oct 2005, Eric Dumazet wrote:

> Dipankar Sarma a écrit :
>> On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
>>>
>>> Fixing the 'file count' wont fix the real problem : Batch freeing is good
>>> but should be limited so that not more than *billions* of file struct are
>>> queued for deletion.
>>
>>
>> Agreed. It is not designed to work that way, so there must be
>> a bug somewhere and I am trying to track it down. It could very well
>> be that at maxbatch=10 we are just queueing at a rate far too high
>> compared to processing.
>>
>
> I can freeze my test machine with a program that 'only' use dentries,
> no files.
>
> No message, no panic, but machine becomes totally unresponsive after
> few seconds.
>
> Just greping for call_rcu in kernel sources gave me another call_rcu() use
> from syscalls. And yes 2.6.13 has the same problem.
>
> Here is the killer on by HT Xeon machine (2GB ram)
>
> Eric
>

No problem with linux-2.6.13.4 and ext3 file-system:
F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
4     0     1     0  16   0  1544  408 -      S    ?          0:00 init [5]
[SNIPPED....]
1     0 16017     6  15   0     0    0 pdflus SW   ?          0:00 [pdflush]
4   666 16406  5273  16   0  4464 1004 wait   S    tty2       0:00 -bash
0   666 16501 16406  18   0  1324  240 -      R    tty2       9:46 ./xxx
4     0 16502  5223  15   0  4204 1248 wait   S    tty1       0:00 -bash
0     0 16563 16502  16   0  2276  584 -      R    tty1       0:00 ps laxw

I just put 9:46 CPU time on your program and every thing is fine.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.46 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
