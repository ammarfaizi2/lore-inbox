Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVC1OiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVC1OiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVC1OiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:38:07 -0500
Received: from terminus.zytor.com ([209.128.68.124]:42720 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261786AbVC1OiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 09:38:05 -0500
Message-ID: <4248168A.20800@zytor.com>
Date: Mon, 28 Mar 2005 06:36:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jayalk@intworks.biz
CC: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [RFC 2.6.11.2 1/1] Add reboot fixup for gx1/cs5530a
References: <200503281415.j2SEFwg4014119@intworks.biz>
In-Reply-To: <200503281415.j2SEFwg4014119@intworks.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jayalk@intworks.biz wrote:
> Hi Riley, Dave, Peter, i386 boot/workaround maintainers,
> 
> I ran into a problem getting reboot working with 2.6.11 on an embedded
> board. The board has a Geode GX1 with a CS5530A companion. What I observe on
> reboot is the "Restarting system" printk, and then a cpu stall/hang. I think
> the problem arises because the keyboard controller is disabled by the BIOS,
> so the traditional mach_reboot()'s output to port 0x64 is ignored. Then the
> 386 triple fault issued after mach_reboot() results in a shutdown (because
> the hardware doesn't have to detect the triple fault and issue a reset).
> That then gives the end result of a stalled cpu/hang. 
> 
> I found that the CS5530A in question has a "issue system wide reset" bit.
> The reboot works cleanly if I write that bit rather than do mach_reboot().
> So the following patch is my attempt to incorporate that change into 2.6.11
> by adding a X86_REBOOTFIXUPS option. In order to keep reboot.c free of hw
> specific fixups, I put it in another file, reboot_fixups.c. I tried to make
> it a bit generic so that if there are other reboot related fixups for other
> chipsets/boards, there'd be a clean place to put it. Please let me know what
> you think.
> 

This makes a lot of sense to me.  I appreciate the fact that you took 
the time to properly add detection/abstraction code.

	-hpa
