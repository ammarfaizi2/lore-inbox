Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUEICAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUEICAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 22:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUEICAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 22:00:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30855 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264182AbUEICAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 22:00:18 -0400
Date: Sat, 8 May 2004 22:04:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Vincent Lefevre <vincent@vinc17.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.26] overcommit_memory documentation clarification
In-Reply-To: <20040509001045.GA23263@ay.vinc17.org>
Message-ID: <Pine.LNX.4.53.0405082142100.25076@chaos>
References: <20040509001045.GA23263@ay.vinc17.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004, Vincent Lefevre wrote:

> Hi,
>
> The documentation of overcommit_memory in Documentation/sysctl/vm.txt
> should be clarified, as with the following simple program, malloc()
> never returns 0 on an official 2.4.26 kernel, even if overcommit_memory
> has been set to 0. Running it has the effect of having random processes
> killed, and eventually this process itself.

What made you think that malloc would return 0 if the system
was "out of memory??" Malloc will return NULL, which is not 0 BTW,
if you are out of address-space or have corrupted it by writing
past a previous allocation. Malloc's return value is a void *. It
should be compared against NULL, not zero.

When malloc() needs new "memory". It just asks the kernel to
set the new break address or, in the case of mmap() mallocs, asks
to extend a mapped region. Until somebody actually uses those
regions, you haven't used any memory. So there is no way for
malloc() to "know" ahead of time.

If you run a malloc() bomb from the root account you should
end up killing off a lot of processes. If you run it from
a normal user account, and you have set the user's resource
quotas properly, only the user should get into trouble.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


