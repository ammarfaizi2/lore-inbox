Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTKTG6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 01:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTKTG6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 01:58:04 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:60802 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S264152AbTKTG57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 01:57:59 -0500
Message-ID: <1069311476.3fbc65f46135c@horde.sandall.us>
Date: Wed, 19 Nov 2003 22:57:56 -0800
From: Eric Sandall <eric@sandall.us>
To: Ben Collins <bcollins@debian.org>
Cc: Nico Schottelius <nico-mutt@schottelius.org>, linux-kernel@vger.kernel.org
Subject: Re: transmeta cpu code question
References: <20031120020218.GJ3748@schottelius.org> <20031120025315.GR11983@phunnypharm.org>
In-Reply-To: <20031120025315.GR11983@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ben Collins <bcollins@debian.org>:

> On Thu, Nov 20, 2003 at 03:02:18AM +0100, Nico Schottelius wrote:
> > Hello!
> > 
> > What does this do:
> > 
> >                 printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u,
> > %u MHz\n",
> >                        (cpu_rev >> 24) & 0xff,
> >                        (cpu_rev >> 16) & 0xff,
> >                        (cpu_rev >> 8) & 0xff,
> >                        cpu_rev & 0xff,
> >                        cpu_freq);
> > 
> > (from arch/i386/kernel/cpu/transmeta.c)
> > 
> > Does not & 0xff make no sense? 0 & 1 makes 0, 1 & 1 makes 1, 
> > no changes.
> >
> > And I don't understand why we do this for 8bit and shifting the
> > cpu_rev...
> 
> You are a bit confused. The cpu_rev is a 4 byte value, each byte is a
> decimal of the revision.
> 
> And (0 & 1) makes 1, not 0. That's an AND, not an OR.

Last I checked, 0 AND anything is 0. Think of it this way:

A   B   A & B
------------
T   F     F
T   T     T
F   T     F
F   F     F

So, anything ANDed with F is false.

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
