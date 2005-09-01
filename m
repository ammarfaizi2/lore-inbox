Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVIAACG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVIAACG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVIAACG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:02:06 -0400
Received: from fmr18.intel.com ([134.134.136.17]:159 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932145AbVIAACF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:02:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Wed, 31 Aug 2005 17:00:41 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A042B03A8@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
Thread-Index: AcWuhs0562DcN/ivSu2/U4mAT8JC0gAAChXQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: <akpm@osdl.org>, <joe.korty@ccur.com>, <george@mvista.com>,
       <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 00:01:34.0024 (UTC) FILETIME=[508EAC80:01C5AE88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Roman Zippel [mailto:zippel@linux-m68k.org]
>On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:
>
>> I cannot produce (top of my head) any other POSIX API calls that
>> allow you to specify another clock source, but they are there,
>> somewhere. If I am to introduce a new API, I better make it
>> flexible enough so that other subsystems can use it for more stuff
>> other than...
>
>So we have to deal at kernel level with every broken timeout
specification
>that comes along?

Hmm, I cannot think of more ways to specify a timeout than how
long I want to wait (relative) or until when (absolute) and which
is the reference clock. And they don't seem broken to me, common
sense, in any case. Do you have any examples?

In any case, like it or not, POSIX is what almost every application
uses to talk to the kernel.

>> ...adding more versions that add complexity and duplicate
>> code in many different places (user-to-kernel copy, syscall entry
>> points, timespec validation). And the minute you add a clock_id
>> you can steal some bits for specifying absolute/relative (or vice
>> versa), so it is almost a win-win situarion.
>
>What "more versions" are you talking about? When you convert a user
time
>to kernel time you can automatically validate it and later you can use
>standard kernel APIs, so you don't have to add even more API bloat.

The versions you were talking about:

>From: Roman Zippel [mailto:zippel@linux-m68k.org]
>...
>Why is not sufficient to just add a relative/absolute version,
>which convert the time at entry to kernel time?

Different versions of the same function that do relative, absolute.
If I keep going that way, the reason becomes:

sys_mutex_lock
sys_mutex_lock_timed_relative_clock_realtime
sys_mutex_lock_timed_absolute_clock_realtime
sys_mutex_lock_timed_relative_clock_monotonic
sys_mutex_lock_timed_absolute_clock_monotonic
sys_mutex_lock_timed_relative_clock_monotonic_highres
sys_mutex_lock_timed_absolute_clock_monotonic_highres

s/mutex_lock/ with whatever system call that takes a timeout you want
and
keep adding combinations. On each of those check for validity of the
__user pointer, copy it, validate the timespec.

[admitedly I am stretching the point with the different clock types].

So where is the problem on unifying all that handling? You are still 
not offering any constructive criticism to solve the issue that now
the syscalls take relative timeouts vs the absolutes we need.

-- Inaky
