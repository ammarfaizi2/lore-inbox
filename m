Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129566AbQKIUaN>; Thu, 9 Nov 2000 15:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131143AbQKIUaD>; Thu, 9 Nov 2000 15:30:03 -0500
Received: from [64.64.109.142] ([64.64.109.142]:26126 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S130788AbQKIU3p>; Thu, 9 Nov 2000 15:29:45 -0500
Message-ID: <3A0B08B9.BE18B538@didntduck.org>
Date: Thu, 09 Nov 2000 15:27:37 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <Pine.LNX.3.95.1001109150621.15404A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 9 Nov 2000, Brian Gerst wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > `lsmod` shows that a device is open twice when using Linux-2.4.0-test9
> > > when, in fact, it has been opened only once.
> > >
> 
> > >
> > > When the module is closed, the use-count goes to zero as expected.
> > > However, a single open() causes the use-count to be 2.
> >
> > This is harmless.  It is caused by a try_inc_mod_count(module) in the
> > function calling device_open(), which is the proper way for module
> > locking to be handled when not holding the BKL.  You can keep the
> > MOD_INC_USE_COUNT in the device driver for compatability with 2.2.
> >
> >                               Brian Gerst
> 
> This may be, as you say, "harmless". It is, however, a bug. The
> reporting must be correct or large complex systems can't be
> developed or maintained.
> 
> I had two persons, working nearly a week, trying to find out
> what one of over 200 processes had a device open when only
> one was supposed to have it opened. --Err we have to check
> our work here. The fact that something "works" is not
> sufficient.

It is not a bug.  The only values that matter are zero and non-zero.  As
long as the refcounting is symmetric, it all comes out in the wash. 
Remove the MOD_{INC,DEC}_USE_COUNT from your driver if it bothers you
that much and you don't care about 2.2 compatability.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
