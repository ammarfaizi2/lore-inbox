Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAKAiF>; Wed, 10 Jan 2001 19:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRAKAhz>; Wed, 10 Jan 2001 19:37:55 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:49528 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129873AbRAKAhn>;
	Wed, 10 Jan 2001 19:37:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jeremyhu@uclink4.berkeley.edu (Jeremy Huddleston),
        linux-kernel@vger.kernel.org
Subject: Re: Problem with module versioning in 2.4.0 
In-Reply-To: Your message of "Thu, 11 Jan 2001 00:17:41 -0000."
             <E14GVR1-0001J9-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 11:37:14 +1100
Message-ID: <7595.979173434@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001 00:17:41 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>jeremyhu wrote
>> See below for my origional problem.  It seems the problem lies in the
>> module versioning option.
>
>Not quite

Probably is.

>> When the system boots, I am spammed with the following line:
>> insmod: /lib/modules/2.4.0/kernel/net/unix/unix.o: insmod net-pf-1
>> failed
>
>What happens is this
>
>kernel needs unix sockets
>kernel invokes modprobe
>modprobe opens a unix socket
>	kernel needs unix sockets
>	kernel invokes modprobe
>		.....

kmod.c has code to catch that recursive case and abort it.  The problem
is not the loop per se, it is caused by that insmod unix.o failing on
every attempt.  That is almost certainly caused by bad symbol versions.
See http://www.tux.org/lkml/#s8-8.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
