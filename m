Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVIGWg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVIGWg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIGWg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:36:58 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:59664 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751316AbVIGWg5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:36:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1126127233.2743.25.camel@syd.mkgnu.net>
References: <1126122068.2744.20.camel@syd.mkgnu.net> <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com> <1126127233.2743.25.camel@syd.mkgnu.net>
X-OriginalArrivalTime: 07 Sep 2005 22:36:54.0112 (UTC) FILETIME=[A595DE00:01C5B3FC]
Content-class: urn:content-classes:message
Subject: Re: [ham] Re: Gracefully killing kswapd, or any kernel thread
Date: Wed, 7 Sep 2005 18:36:53 -0400
Message-ID: <Pine.LNX.4.61.0509071826180.4951@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ham] Re: Gracefully killing kswapd, or any kernel thread
Thread-Index: AcWz/KWdBLnnEFMcSmSqiCxmH5x7OQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kristis Makris" <kristis.makris@asu.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Sep 2005, Kristis Makris wrote:

>> To kill a kernel thread, you need to make __it__ call exit(). It must be
>
> There must be another way to do it. Perhaps one could have another
> process effectively issue the contents of do_exit for the kswapd
> task_struct ?
>
>> CODED to do that! You can't do it externally although you can send
>
> I'm clearly asking for the case where the thread wasn't coded to do
> that.
>

It was not clear. You just sent it a signal and expected it to go
away. No tasks, even user-mode tasks, just go away! They need to
execute the exit code in the context of the task that will
expected to eventually disappear. It's contents of "current"
that tells the exit code what to clean up.

This means that you could probably install a driver that patches
some code that the kernel thread executes. Nothing like
modifying code at run-time....

>> it a signal, after which it will spin forever....
>
> kflushd and keventd don't seem to spin forever. I still haven't
> determined what makes kswapd spin forever after it receives the signal.
>

It depends how the signal was masked and how the thread was written.
Notice in the example posted, the code was reset to TASK_INTERRUPTIBLE
each time the loop was executed. If this is not done, the task won't
get interrupted by a signal again.

>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
