Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRCWB7E>; Thu, 22 Mar 2001 20:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRCWB6z>; Thu, 22 Mar 2001 20:58:55 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:18441 "HELO
	zcamail03.zca.compaq.com") by vger.kernel.org with SMTP
	id <S129245AbRCWB6o>; Thu, 22 Mar 2001 20:58:44 -0500
Reply-To: <frey@cxau.zko.dec.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 17:57:51 -0800
Message-ID: <008901c0b33c$ab1f51a0$90600410@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3ABA92F0.CF6729C2@uow.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  - When started during boot (low PID (9)) It becomes a zombie
>>  - When started from a process that quits after sending the ioctl,
>>    it is correctly "garbage collected".
>>  - When started from a process that stays around, it becomes 
>>    a zombie too

>Take a look at kernel/kmod.c:call_usermodehelper().  Copy it.
>
>This will make your thread a child of keventd.  This takes
>care of things like chrootedness, uids, cwds, signal masks,
>reaping children, open files, and all the other crud which
>you can accidentally inherit from your caller.
>
So depending on the state of the caller daemonize() will not really
put us into the background as we want. With being created from
keventd we inherit a state as we'd like to have in a kernel thread.
Did I get it right?
I will change my example and test that.

Thanks,

Martin
