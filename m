Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDKQck (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbTDKQck (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:32:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11656 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261177AbTDKQci (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 12:32:38 -0400
Date: Fri, 11 Apr 2003 12:46:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sriram Narasimhan <nsri@tataelxsi.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tasklet doubt!
In-Reply-To: <3E96EAF5.4060609@tataelxsi.co.in>
Message-ID: <Pine.LNX.4.53.0304111242210.8834@chaos>
References: <3E96EAF5.4060609@tataelxsi.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Sriram Narasimhan wrote:

> Hello,
>
> How much of memory can be allocated from a tasklet ? [ kmalloc
> (GFP_ATOMIC) ].
>
> I was able to allocate upto 2.5 MB. But I would like to allocate upto
> 8MB. Is this possible?
>
> The physical RAM limit is 64 MB. I am running 2.4.7-10 RH 7.2 on i386.
>
> Any suggestions or pointers could be very helpful.
>
> Thank you.
> Regards,
> Sriram

Maybe you do not have to dynamically allocate memory? You
can allocate kmalloc(GFP_KERNEL) during initialization
and only free it when you remove a module. That way, it's
always there. Such RAM is still okay for interrupts because
kernel RAM is never swapped out. You only need GFP_ATOMIC for
stuff allocated and freed when the interrupts are off like
in ISRs.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

