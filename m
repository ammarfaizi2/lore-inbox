Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJNC0S>; Sat, 13 Oct 2001 22:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRJNC0J>; Sat, 13 Oct 2001 22:26:09 -0400
Received: from otter.mbay.net ([206.40.79.2]:33293 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S273565AbRJNCZ4> convert rfc822-to-8bit;
	Sat, 13 Oct 2001 22:25:56 -0400
From: John Alvord <jalvo@mbay.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: =?utf-8?Q?Mattias_Engdeg=C3=A5rd?= <f91-men@nada.kth.se>,
        pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
Date: Sat, 13 Oct 2001 19:25:03 -0700
Message-ID: <tothstsfpl2t6b92f58mj8bv5j6005t0p3@4ax.com>
In-Reply-To: <E15p3JS-0000ko-00@pmenage-dt.ensim.com> <200110041418.QAA17395@my.nada.kth.se> <20011013173619.C20499@kushida.jlokier.co.uk>
In-Reply-To: <20011013173619.C20499@kushida.jlokier.co.uk>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 17:36:19 +0200, Jamie Lokier
<lk@tantalophile.demon.co.uk> wrote:

>Mattias Engdegård wrote:
>> I don't think it's contrived --- writing not a byte, but the pid and
>> return status of the dead child to a pipe is an old but useful trick.
>> It gives a natural serialisation of child deaths, and also eliminates
>> the common race where a child dies before its parent has recorded its
>> pid in a data structure. See it as a safe way of converting an
>> asynchronous signal to a queued event.
>>
>> Using pipes to wake up blocking select()s is a useful thing in general,
>> and often a lot cleaner than using signals when dealing with threads.
>
>This mistake is exactly the reason that Netscape 4.x freezes from time
>to time on Linux.
>
>It tries to write too many things to a pipe, making the assumption that
>this will never happen.

At one point a few years ago, someone implemented a loadable library
which "fixed" the Netscape problem by knowing what the bug was, doing
things the right way, and presenting the interface Netscape expected.

john
