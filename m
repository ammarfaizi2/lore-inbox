Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSCNTr0>; Thu, 14 Mar 2002 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311750AbSCNTrR>; Thu, 14 Mar 2002 14:47:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311749AbSCNTrB>; Thu, 14 Mar 2002 14:47:01 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Date: 14 Mar 2002 11:46:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6quma$7pd$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203141802330.1477-100000@biker.pdb.fsc.net> <E16lZg3-0001Ug-00@the-village.bc.nu> <a6qtb8$6fg$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <a6qtb8$6fg$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
> 
> I suspect the _real_ solution is to stop using "inb_p/outb_p" and make
> the delay explicit, although it may be that some drivers depend on the
> fact that not only is the "outb $0x80" a delay, it also tends to act as
> a posting barrier.
> 

... as well as a push-out to the ISA bus.  I suspect dumping the outb
way of doing it and instead wait in the CPU might cause the delay to
happen in the wrong part of the system (consider split-transaction
queued busses like HyperTransport, where a delay in the CPU doesn't
necessarily mean a delay in the southbridge.)

Port 0x80 has served us well, at least as a default.  If you really
care about the POST display you can recompile using a different port.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
