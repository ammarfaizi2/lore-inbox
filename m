Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318351AbSG3RBD>; Tue, 30 Jul 2002 13:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318352AbSG3RBD>; Tue, 30 Jul 2002 13:01:03 -0400
Received: from deming-os.org ([63.229.178.1]:38665 "EHLO deming-os.org")
	by vger.kernel.org with ESMTP id <S318351AbSG3RBC>;
	Tue, 30 Jul 2002 13:01:02 -0400
Message-ID: <3D46C6AB.1000103@deming-os.org>
Date: Tue, 30 Jul 2002 10:02:35 -0700
From: Russell Lewis <spamhole-2001-07-16@deming-os.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
References: <Pine.LNX.3.95.1020730124325.5378A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>On Tue, 30 Jul 2002, Russell Lewis wrote:
>
>You need to gain a lock just to read the bias field. You can't read
>something that somebody else will change while you are deciding
>upon what you read. It just can't work.
>
I intentionally made bias a non-precise field.  It really doesn't matter 
if it gets corrupted; it is just a rough idea of what's going on.  So 
there's no problem reading it without a lock.  If the value you read is 
wrong (or partial), then the worst that happends is bunch of NOPs before 
you try for the lock (an undesirable, but not disastrous occurance).

>If we presume that it did work. What problem are you attempting
>to fix?  FYI, there are no known 'lock-hogs'. Unlike a wait on
>a semaphore, where a task waiting will sleep (give up the CPU), a
>deadlock on a spin-lock isn't possible. A task will eventually
>get the resource. Because of the well-known phenomena of "locality",
>every possible 'attack' on the spin-lock variable will become
>ordered and the code waiting on the locked resource will get
>it in a first-come-first-served basis. This, of course, assumes
>that the code isn't broken by attempts to change the natural
>order.
>
Check out the title of the thread...  Somebody has a real, reproducible 
deadlock on a rw_lock where many readers are starving out a writer, and 
the system hangs.

