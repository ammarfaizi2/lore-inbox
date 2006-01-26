Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWAZT6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWAZT6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWAZT6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:58:23 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:56582 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751386AbWAZT6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:58:22 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <hyc@symas.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Thu, 26 Jan 2006 11:57:27 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D8E023.8080504@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 26 Jan 2006 11:54:15 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 26 Jan 2006 11:54:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The point of this discussion is that the POSIX spec says one thing and
> you guys say another; one way or another that should be resolved. The
> 2.6 kernel behavior is a noticable departure from previous releases. The
> 2.4/LinuxThreads guys believed their implementation was correct. If you
> believe the 2.6 implementation is correct, then you should get the spec
> amended or state up front that the "P" in "NPTL" doesn't really mean
> anything.

	There is disagreement over what the POSIX specification says. You have
already seen three arguments against your interpretation, any one of which
is, IMO, sufficient to demolish it.

	First, there's the as-if issue. You cannot write a program that can print
"non-compliant" with the behavior you claim is non-compliant that is
guaranteed not to do so by the standard because there is no way to know that
another thread is blocked on the mutex (except for PI mutexes).

	Second, there's the plain langauge of the standard. It says "If X is so at
time T, then Y". This does not require Y to happen at time T. It is X
happening at time T that requires Y, but the time for Y is not specified.

	If a law says, for example, "if there are two or more bids with the same
price lower than all other bids at the close of bidding, the first such bid
to be received shall be accepted". The phrase "at the close of bidding"
refers to the time the rule is deteremined to apply to the situation, not
the time at which the decision as to which bid to accept is made.

	Third, there's the ambiguity of the standard. It says the "sceduling
policy" shall decide, not that the scheduler shall decide. If the policy is
to make a conditional or delayed decision, that is still perfectly valid
policy. "Whichever thread requests it first" is a valid scheduler policy.

	DS


