Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUBKVdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUBKVdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:33:53 -0500
Received: from extavgw4.ball.com ([162.18.103.211]:5135 "HELO
	extavgw4.ball.com") by vger.kernel.org with SMTP id S266153AbUBKVdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:33:49 -0500
Date: Wed, 11 Feb 2004 14:32:43 -0700
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel boot crashing
Message-ID: <20040211213243.GA5133@ball.com>
Reply-To: tevaugha@ball.com, tevaughan@comcast.net
Mail-Followup-To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20040211154044.GA656@ball.com> <E1Aqxgm-0005G4-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <E1Aqxgm-0005G4-00@chiark.greenend.org.uk>
X-Operating-System: Linux hypostasis 2.6.2 
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "Thomas E. Vaughan" <tevaugha@ball.com>
X-OriginalArrivalTime: 11 Feb 2004 21:32:43.0780 (UTC) FILETIME=[957F5440:01C3F0E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2004 at 04:58:16PM +0000, Matthew Garrett
wrote:
>
> Thomas E. Vaughan wrote:
> 
> >PnPBIOS: PnP BIOS version 1.0, entry 0xf000:0x6d5a, dseg 0xf000
> >general protection fault: 0000 [#1]
> 
> There have been problems with PnP BIOS support on various
> motherboards.  Try rebuilding the kernel package without
> PNPBIOS support (you probably don't need it - it's there
> in order to manage resource allocation for legacy hardware
> like serial ports, and in most cases the BIOS will happily
> set those up on its own) and see if that works.

That did the trick.  The only config option that matters is

   "Plug and Play BIOS support (EXPERIMENTAL)",

which must *not* be selected.  I noticed that the top-level

   "Plug and Play support"

and also

   "ISA Plug and Play support (EXPERIMENTAL)"

can be selected, and the kernel still boots OK.  But that
PnPBIOS support crashes the kernel hard.

Is it reasonable to request that Herbert Xu, or whoever is
in charge of configuring the relevant Debian kernels, turn
off the PnPBIOS support until this is fixed upstream.
Should someone (like me) file a bug report?  If so, then
against which package?

> If so, send a copy of the oops and your kernel version to
> linux-kernel@vger.kernel.org and the kernel developers
> will deal with it.

I'll attach my original report to this message and copy it
to linux-kernel.

> Another thing worth trying is to make sure your BIOS is
> fully up to date.

What's the best way of doing that?  I just bought this
2.8-GHz Pentium 4 machine in mid-December from Best Buy, so
I don't imagine that the BIOS is particularly old, but I
don't know how to tell.

-- 
Thomas E. Vaughan   (303) 939-6386   Ball Aerospace, Boulder

--J2SCkAp4GZ/dPZZf
Content-Type: message/rfc822
Content-Disposition: inline

Received: from hypostasis ([162.18.79.136]) by APPMSG3.AERO.BALL.COM with Microsoft SMTPSVC(5.0.2195.5329);
	 Wed, 11 Feb 2004 08:40:44 -0700
Received: from tevaugha by hypostasis with local (Exim 3.36 #1 (Debian))
	id 1AqwTk-0000Bg-00; Wed, 11 Feb 2004 08:40:44 -0700
Date: Wed, 11 Feb 2004 08:40:44 -0700
To: debian-devel@lists.debian.org
Subject: 2.6 kernel boot crashing
Message-ID: <20040211154044.GA656@ball.com>
Reply-To: tevaugha@ball.com, tevaughan@comcast.net
Mail-Followup-To: debian-devel@lists.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux hypostasis 2.4.24-1-686 
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "Thomas E. Vaughan" <tevaugha@ball.com>
Return-Path: tevaugha@ball.com
X-OriginalArrivalTime: 11 Feb 2004 15:40:44.0984 (UTC) FILETIME=[69B6CB80:01C3F0B5]


I have an HP Pavilion A350N that I purchased from Best Buy a
couple of months ago.  It has a 2.8-GHz Pentium 4 processor
"with Hyper-Threading Technology".  Anyway, I'm running
Debian unstable, and every 2.6 kernel image that I have
installed has crashed at boot time.  I have not tried
compiling my own, but I have tried both the -686 and the
-386 packages.  Here's what I copied off of the black screen
before unplugging the machine from the wall.

----------BEGIN HAND-COPY FROM SCREEN----------
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5f50
PnPBIOS: PnP BIOS version 1.0, entry 0xf000:0x6d5a, dseg 0xf000
general protection fault: 0000 [#1]
CPU:    0
EIP:    0098:[<00001f1c>]   Not tainted
EFLAGS: 00010083
EIP is at 0x1f1c
eax: 000022ec  ebx: 0000005d  ecx: 00010000  edx: 00000001
esi: f7fa1cd4  edi: 00000015  ebp: f7fa0000  esp: f7fa1efa
ds: 00b0  es: 00b0  ss: 0068
Process swapper (pid: 1, threadinfo=f7fa0000 task=c1b21900)
Stack: 000002ec 22ec1d8e 00000000 8f9d0015 0006c7b3 00010001 1f4c8f3c 0015c7ba
       1f4c0000 c7b31f28 00060001 70190606 01060106 007b6e74 0000007b 00a00000
       6e3000b0 00a86df6 00000082 000b0000 00010090 00a80000 00b00000 00a00001
Call Trace:

Code: Bad EIP value
 <0>Kernel panic: Attempted to kill init!
----------END HAND-COPY FROM SCREEN----------

-- 
Thomas E. Vaughan   (303) 939-6386   Ball Aerospace, Boulder

--J2SCkAp4GZ/dPZZf--
