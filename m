Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWGHXLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWGHXLE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 19:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWGHXLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 19:11:03 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:4624 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030419AbWGHXLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 19:11:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 16:10:54 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEMHNAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 08 Jul 2006 16:06:15 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 08 Jul 2006 16:06:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Damn right. This is the C standard requirement.
> Not all code has Linux-like performance requirements,
> and in any case, standards are standards.

	Umm, no it's not a C standard requirement. The C standard requires
'volatile' to work in two specific cases (signals and longjmp) and further
defines certain side-effects of 'volatile' accesses that must not be removed
under any 'as-if' optimizations. GCC fully respects these three
requirements.

	For anything else, if you cannot detect it in a compliant program, it is
not a violation of the standard. Programs compliant with the C standard
cannot access shared memory that may be modified by another process nor can
they have multiple threads concurrently executing. So any proposed violation
that can only be exposed under those circumstances is not actually a
violation.

	POSIX, for several good reasons, did not extend 'volatile' to provide any
guarantees when used in conjunction with things like 'mmap' and pthreads.
For one thing, it would have added senseless expensive overhead to programs
that used 'volatile' legitimately.

	Worse, it would have opened up the atomicity Pandora's box.

	It's hard to imagine how 'volatile' could possibly be useful in an SMP
context if it has no atomicity guarantees, and it has no atomicity
guarantees. No standard, as far as I know, has ever expanded 'volatile' to
include atomicity guarantees, so it's totally and completely useless in an
SMP context. So can this argument die now?

	DS


