Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSG3QxW>; Tue, 30 Jul 2002 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318350AbSG3QxW>; Tue, 30 Jul 2002 12:53:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318348AbSG3QxV>; Tue, 30 Jul 2002 12:53:21 -0400
Date: Tue, 30 Jul 2002 12:56:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
In-Reply-To: <3D46B7C2.2010905@deming-os.org>
Message-ID: <Pine.LNX.3.95.1020730124325.5378A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Russell Lewis wrote:

> IDEA: Implement a read/write "bias" field that can show if a lock has 
> been gained many  times in succession for either read or write.  When 
> locks of the opposite type are attempting (and failing) to get the lock, 
> back off the other users until starvation is relieved.
> 

You need to gain a lock just to read the bias field. You can't read
something that somebody else will change while you are deciding
upon what you read. It just can't work.

If we presume that it did work. What problem are you attempting
to fix?  FYI, there are no known 'lock-hogs'. Unlike a wait on
a semaphore, where a task waiting will sleep (give up the CPU), a
deadlock on a spin-lock isn't possible. A task will eventually
get the resource. Because of the well-known phenomena of "locality",
every possible 'attack' on the spin-lock variable will become
ordered and the code waiting on the locked resource will get
it in a first-come-first-served basis. This, of course, assumes
that the code isn't broken by attempts to change the natural
order.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

