Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUBYVmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbUBYVlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:41:17 -0500
Received: from news.cistron.nl ([62.216.30.38]:43465 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261610AbUBYVjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:39:24 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: IO scheduler, queue depth, nr_requests
Date: Wed, 25 Feb 2004 21:39:23 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c1j4mb$gmd$1@news.cistron.nl>
References: <1qJVx-75K-15@gated-at.bofh.it> <1r6fH-3L8-11@gated-at.bofh.it> <1r6S4-6cv-1@gated-at.bofh.it> <403D02E3.4070208@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1077745163 17101 62.216.29.200 (25 Feb 2004 21:39:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <403D02E3.4070208@tmr.com>,
Bill Davidsen  <davidsen@tmr.com> wrote:
>linux.kernelNick Piggin wrote:
>
>> But the whole reason it is getting blocked in the first place
>> is because your controller is sucking up all your requests.
>> The whole problem is not a problem if you use properly sized
>> queues.
>> 
>> I'm a bit surprised that it wasn't working well with a controller
>> queue depth of 64 and 128 nr_requests. I'll give you a per process
>> request limit patch to try in a minute.
>
>And there's the rub... he did try what you are calling correctly sized 
>queues, and his patch works better. I'm all in favor of having the 
>theory and then writing the code, but when something works I would 
>rather understand why and modify the theory.

Ah, but we now do understand why - it was pdflush and a process
fighting over get_request on basically the same device, before and
after LVM remapping.

See:

http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/1522.html

More complete solutions:

https://www.redhat.com/archives/linux-lvm/2004-February/msg00203.html
https://www.redhat.com/archives/linux-lvm/2004-February/msg00215.html

Mike.

