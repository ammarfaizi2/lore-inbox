Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWAZCG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWAZCG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWAZCG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:06:28 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:62478 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751257AbWAZCG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:06:27 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Christopher Friesen" <cfriesen@nortel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <hancockr@shaw.ca>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Wed, 25 Jan 2006 18:05:47 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEJEJKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D7F863.3080207@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 25 Jan 2006 18:02:37 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 25 Jan 2006 18:02:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Kaz's post clearly interprets the POSIX spec differently from you. The
> policy can decide *which of the waiting threads* gets the mutex, but the
> releasing thread is totally out of the picture. For good or bad, the
> current pthread_mutex_unlock() is not POSIX-compliant. Now then, if
> we're forced to live with that, for efficiency's sake, that's OK,
> assuming that valid workarounds exist, such as inserting a sched_yield()
> after the unlock.

	My thanks to David Hopwood for providing me with the definitive refutation
of this position. The response is that the as-if rules allows the
implementation to violate the specification internally provided no compliant
application could tell the difference.

	When you call 'pthread_mutex_lock', there is no guarantee regarding how
long it will or might take until you are actually waiting for the mutex. So
no conforming application can ever tell whether or not it is waiting for the
mutex or about to wait for the mutex.

	So you cannot write an application that can tell the difference.

	His exact quote is, "It could have been the case that the other threads ran
more slowly, so that they didn't reach the point of blocking on the mutex
before the pthread_mutex_unlock()."

	You can find it on comp.programming.threads if you like.

	DS


