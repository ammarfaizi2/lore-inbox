Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131702AbRCURRz>; Wed, 21 Mar 2001 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRCURRq>; Wed, 21 Mar 2001 12:17:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15114 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131643AbRCURR1>; Wed, 21 Mar 2001 12:17:27 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: SMP on assym. x86
Date: 21 Mar 2001 09:16:20 -0800
Organization: Transmeta Corporation
Message-ID: <99anl4$8oi$1@penguin.transmeta.com>
In-Reply-To: <20010321165541.H3514@garloff.casa-etp.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010321165541.H3514@garloff.casa-etp.nl>,
Kurt Garloff  <garloff@suse.de> wrote:
>
>recently upgrading one of my two CPUs, I found kernel-2.4.2 to be unable to
>handle the situation with 2 different CPUs (AMP =3D Assymmetric
>multiprocessing ;-) correctly.

This is not really a configuration Linux supports. You can hack it to
work in many cases, but I'm generally not inclined to make this a an
issue for me because:

 - intel explicitly doesn't support it necessarily even in hardware.
   You're supposed to only mix CPU's of the same stepping within a
   family, never mind different families.  They sometimes explicitly say
   which steppings are compatible and can be mixed.

   NOTE! For all I know, this might, for all I know, actually be due to
   fundamental issues like cache coherency protocol timing or similar.
   Safe answer: just say no.

 - The boot CPU under Linux is special, and will be used to determine
   things like support for 4M pages etc. It will then re-write the page
   tables to be more efficient. If the other CPU's don't support all the
   features the boot CPU has, they'll have serious trouble booting up. 

   NOTE! I'm not all that interested in trying to complicate the bootup
   logic to take into account all the differences that can occur.
   Especially as it only happens on arguably very broken hardware that
   doesn't meet the specs anyway.

So I'm perfectly happy with you fixing it on your machine, but right now
I have no incentives to make this a "real" option for a standard kernel.

I retain the right to change my mind, as always. Le Linus e mobile.

		Linus
