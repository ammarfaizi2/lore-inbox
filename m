Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTD2Sh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTD2Sh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:37:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35982 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262127AbTD2Shy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:37:54 -0400
Date: Tue, 29 Apr 2003 14:53:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David van Hoose <davidvh@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question regarding inactive memory
In-Reply-To: <3EAEC5BC.3070008@cox.net>
Message-ID: <Pine.LNX.4.53.0304291444240.5847@chaos>
References: <3EAEC5BC.3070008@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003, David van Hoose wrote:

> This may be a bit of a newbie'ish question, and maybe a bit off-topic,
> but is there any way for me to remove inactive memory, either explicitly
> or implicitly? I have 512MB of PC2700 SDRAM, but my system is constantly
> eating into the swap I have on my system since I have usually about
> 140-300MB of inactive (and dirty) RAM and usually about only 250MB in
> active memory. Is there a way for me to correct this bad memory usage
> without having to reboot? If patching the kernel would be a possible
> route to venture to, I'm game.
>
> Any suggestions or comments are welcome.
>
> Thank you all!
> David
>

Assuming you are not using a development kernel, the memory
manager will try to use most all available RAM. This is
normal. During most usage, many of the daemons get swapped out,
and unless they are awakened, they don't get swapped back in.
This is normal because one does not want to waste the CPU
cycles necessary to swap back in RAM data that will not be
used.

The purpose of using most all available RAM is to save CPU
cycles and make the machine responsive. If you have a program
that needs RAM, it is grabbed from those buffers you see if
you do `cat /proc/meminfo`. The idea is to nat waste any
RAM.

If you want to just write the stuff on your swap device(s)
back to RAM, to see that it "really works", just execute,
`swapoff -a` as root. You can then execute `swapon -a` and
you are back to "normal".

The 'dirty' buffers are kept around, even after being written
to disk, so they don't have to be re-read the next time you
execute `ls` or run a program.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

