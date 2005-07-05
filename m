Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVGESJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVGESJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGESJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:09:37 -0400
Received: from alog0470.analogic.com ([208.224.222.246]:25821 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261930AbVGESJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:09:32 -0400
Date: Tue, 5 Jul 2005 14:08:23 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: man sendto ENOBUFS desc. wrong
In-Reply-To: <20050705171600.GA18778@kestrel>
Message-ID: <Pine.LNX.4.61.0507051356470.5000@chaos.analogic.com>
References: <20050705171600.GA18778@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, Karel Kulhavy wrote:

> man send(2):
>
> "       ENOBUFS
> 	      The output queue for a network interface was full.  This
> gener- ally  indicates  that the interface has stopped sending, but may
> be caused by transient congestion.   (Normally,  this does  not occur
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> in Linux. Packets are just silently dropped when a device queue
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> overflows.)"
> ^^^^^^^^^^
>
> Which is not true, because just happened to me with kernel Linux version
> 2.6.11-gentoo-r9.
>
> Where should I report?
>
> CL<

The `man` pages concatenate send() sendmsg() sendto(), etc. So, what
are you trying to do? If you are using a CONNECTED STREAM socket,
the end-points get perfect data-buffers with nothing dropped, even
if you disconnect the physical wire for quite some time (hours).

In that case, the errors returned are EAGAIN, EBADF, ECONNRESET,
EFAULT, EINTR, EINVAL, ENOTCON, etc. No errors about the interface
are returned because the kernel transparently retries those errors.

Data-grams can be dropped on the floor for any number of reasons
including the phase of the moon. If you are not prepared to handle
this, you must use a CONNECTED STREAM socket. You can't have it
both ways. You either have a perfect data-transmission path with
its associated overhead, or you get a faster transmission but
are not guaranteed anything, including the even one packet gets
to the end-point.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
