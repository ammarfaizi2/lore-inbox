Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTKTCzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTKTCzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:55:47 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:25282 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264272AbTKTCzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:55:45 -0500
Date: Wed, 19 Nov 2003 21:53:15 -0500
From: Ben Collins <bcollins@debian.org>
To: Nico Schottelius <nico-mutt@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: transmeta cpu code question
Message-ID: <20031120025315.GR11983@phunnypharm.org>
References: <20031120020218.GJ3748@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120020218.GJ3748@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 03:02:18AM +0100, Nico Schottelius wrote:
> Hello!
> 
> What does this do:
> 
>                 printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u,
> %u MHz\n",
>                        (cpu_rev >> 24) & 0xff,
>                        (cpu_rev >> 16) & 0xff,
>                        (cpu_rev >> 8) & 0xff,
>                        cpu_rev & 0xff,
>                        cpu_freq);
> 
> (from arch/i386/kernel/cpu/transmeta.c)
> 
> Does not & 0xff make no sense? 0 & 1 makes 0, 1 & 1 makes 1, 
> no changes.
>
> And I don't understand why we do this for 8bit and shifting the
> cpu_rev...

You are a bit confused. The cpu_rev is a 4 byte value, each byte is a
decimal of the revision.

And (0 & 1) makes 1, not 0. That's an AND, not an OR.

Think about it this way. If cpu_rev == 0x01040801, then this would
produce:

(0x01040801 >> 24 & 0xff) -> (0x01 & 0xff) ->     0x01

(0x01040801 >> 16 & 0xff) -> (0x0104 & 0xff) ->   0x04

(0x01040801 >> 8  & 0xff) -> (0x010408 & 0xff) -> 0x08

(0x01040801 & 0xff)                            -> 0x01


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
