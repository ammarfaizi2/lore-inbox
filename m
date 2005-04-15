Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVDOUjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVDOUjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVDOUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:39:13 -0400
Received: from alog0054.analogic.com ([208.224.220.69]:51651 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261961AbVDOUjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:39:08 -0400
Date: Fri, 15 Apr 2005 16:38:27 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Daniel Souza <thehazard@gmail.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Igor Shmukler <igor.shmukler@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
In-Reply-To: <e1e1d5f4050415131977a776e9@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504151628210.662@chaos.analogic.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
 <1113588694.6694.75.camel@laptopd505.fenrus.org> <6533c1c905041512411ec2a8db@mail.gmail.com>
 <e1e1d5f40504151251617def40@mail.gmail.com> <6533c1c905041512594bb7abb4@mail.gmail.com>
 <e1e1d5f40504151310467d16bd@mail.gmail.com> <1113596014.6694.87.camel@laptopd505.fenrus.org>
 <e1e1d5f4050415131977a776e9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Daniel Souza wrote:

> On 4/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
>> On Fri, 2005-04-15 at 13:10 -0700, Daniel Souza wrote:
>>> You're welcome, Igor. I needed to intercept syscalls in a little
>>> project that I were implementing, to keep track of filesystem changes,
>>
>> I assume you weren't about tracking file content changing... since you
>> can't do that with syscall hijacking.. (that is a common misconception
>> by people who came from a MS Windows environment and did things like
>> anti virus tools there this way)
>
> No, I was tracking file creations/modifications/attemps of
> access/directory creations|modifications/file movings/program
> executions with some filter exceptions (avoid logging library loads by
> ldd to preserve disk space).
>
> It was a little module that logs file changes and program executions
> to syslog (showing owner,pid,ppid,process name, return of
> operation,etc), that, used with remote syslog logging to a 'strictly
> secure' machine (just receive logs), keep security logs of everything
> (like, it was possible to see apache running commands as "ls -la /" or
> "ps aux", that, in fact, were signs of intrusion of try of intrusion,
> because it's not a usual behavior of httpd. Maybe anyone exploited a
> php page to execute arbitrary scripts...)
>
> --

The requirements can be easily met in user-mode, probably
a lot easier than anything in the kernel.

LD_PRELOAD some custom 'C' runtime library functions, grab open()
read(), write(), etc. Write information to a pipe. Secure reader
daemon logs whatever it wants, based upon configuration settings.
After writing information to the pipe, executes the appropriate
syscall.

Done, no hacks, everything working in the correct context.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
