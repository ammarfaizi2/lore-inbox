Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUBWOmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUBWOmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:42:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23427 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261876AbUBWOmO
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:42:14 -0500
Date: Mon, 23 Feb 2004 09:43:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Coywolf Qi Hunt <coywolf@greatcn.org>
cc: tao@acc.umu.se, alan@lxorguk.ukuu.org.uk,
       Linux kernel <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix GDT limit in setup.S for 2.0 and 2.2
In-Reply-To: <403A07D8.5050704@greatcn.org>
Message-ID: <Pine.LNX.4.53.0402230933190.8770@chaos>
References: <403114D9.2060402@lovecn.org> <403A07D8.5050704@greatcn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Coywolf Qi Hunt wrote:

> Hello,
>
> I posted this problem days ago. Just now I check FreeBSD code and find
> theirs code goes no this problem. Please take my patches for 2.0 and 2.2
> 2.4 patch have been already sent to Anvin.
>
> (patches for 2.0 and 2.2 enclosed)
>
>
> 	Coywolf
>

Please review pages 5-10 thru 5-11 or the Intel 484 Programmer's
Reference manual and then tell me what you think you are doing.

Screwing around with that GDT will cause large kernels, i.e.,
kernels that have RAM disks, to fail to load. I already explained
what the elements in the GDT mean. You seem to think you know
more than those at Intel who wrote the book.

As the text in page 5-11 shows, if the granularity bit is '1'
The limit value is from 4 kilobytes to 4 gigabytes in increments
of 4K bytes. You just set that value to 2048 * 4096 = 8,388,608 bytes.
This means I can't load a 10 megabyte RAM disk. Stop screwing
with the startup code, you absolutely-positively don't have a clue
what you are doing.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


