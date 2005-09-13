Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVIMUOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVIMUOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVIMUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:14:12 -0400
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:61382 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932215AbVIMUOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:14:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=tN1vOKcd/qAgWgLuO32dYoYxsrWB7I9sK3rpKLAii2MP9qgkdN7DdvVqhreUtLXF;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MIMEOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <02e201c5b89f$a3248e80$1925a8c0@Thing>
From: "jdow" <jdow@earthlink.net>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Mark Hounschell" <markh@compro.net>
Cc: <linux-kernel@vger.kernel.org>
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
Subject: Re: HZ question
Date: Tue, 13 Sep 2005 13:13:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711201bfaba1a6d7a0eb879ae450543dd1a84c15434412965c95d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.177.219
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>
> On Tue, 13 Sep 2005, Mark Hounschell wrote:
>
>> I need to know the kernels value of HZ in a userland app.
>>
>> getconf CLK_TCK
>>      and
>> hz = sysconf (_SC_CLK_TCK)
>>
>> both seem to return CLOCKS_PER_SEC which is defined as USER_HZ which is
>> defined as 100.
>>
>> include/asm/param.h:
>>
>> #ifdef __KERNEL__
>> # define HZ       1000   /* Internal kernel timer frequency */
>> # define USER_HZ  100    /* .. some user interfaces are in "ticks" */
>> # define CLOCKS_PER_SEC  (USER_HZ)       /* like times() */
>> #endif
>>
>> Thanks in advance for any help
>> Mark
>
> You are not supposed to 'tear apart' user-mode headers. In particular
> you are not supposed to use anything in /usr/include/bits, 
> /usr/include/asm,
> or /usr/include/linux in user-mode programs. These are not POSIX headers.
>
> Therefore, HZ is not something that is defined for user-mode programs.
> the ANSI spec requires that things like clock() return a value that
> can be divided by CLOCKS_PER_SEC to get CPU time. Nothing in user-mode
> uses HZ.  That's the reason why later versions of the kernel are
> able to use dynamic HZ.

That means Linux is not a suitable operating system for multimedia 
applications.
MIDI needs to schedule in 1 ms or smaller increments. The userland 
application
should be able to set this. It should be able to determine this. If it 
cannot
then it is useless. (It also explains why MIDI based applications are so
absolutely dreadful on Linux.)

{^_^}   Joanne Dow said that. 

