Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTEEQxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTEEQvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:51:45 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:40429 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263650AbTEEQvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:51:04 -0400
Date: Mon, 5 May 2003 19:15:01 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: S-n-e-a-k-e-r@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: questions regarding arch/i386/boot/setup.S
Message-ID: <20030505171501.GL1074@wind.cocodriloo.com>
References: <23912.1052135086@www4.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23912.1052135086@www4.gmx.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 01:44:46PM +0200, S-n-e-a-k-e-r@gmx.net wrote:
> I write this to the kernel mailing list, because my question couldn't be
> answered on irc (eg. irc.kernelnewbie.org):
> ____________________________________________________________________________
> arch/i386/boot/setup.S:
> 
> 164 trampoline:     call    start_of_setup
> 165                 .space  1024
> 166 # End of setup header
> #####################################################
> 167 
> 168 start_of_setup:
> 169 # Bootlin depends on this being done early
> 170         movw    $0x01500, %ax
> ____________________________________________________________________________
> my questions are:
> 
> -)    Why is there a call on line 164 and not a jmp?
> -)    Why does line 165 reserve 1024 bytes? what is it for?
> -)    On line 170: Why $0x01500 and not $0x1500?
> 
> I would appreciate if someone could answer this mail, or if someone can
> provide ressources where I can find detailed description of the kernel code
> (didn't find anything, just overall information)

Andy, "call" pushes �"eip" into the stack, so later on
you can do "mov [esp],edx" and use edx as a pointer
to this 1024-bytes space.

This is a way to perform pc-relative addressing on
architectures which don't allow it directly such as
i386 (if I remember correctly).

Compare this to, for example, m68k, where
you can do "move label(pc),d0" to perform pc-relative
addressing if "label" is located near the current pc.

Greetz, Antonio.

