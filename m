Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTD3XJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTD3XJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:09:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262513AbTD3XJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:09:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: software reset
Date: 30 Apr 2003 16:20:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8plok$u51$1@cesium.transmeta.com>
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel> <p73vfwx2uw8.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p73vfwx2uw8.fsf@oldwotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
>
> joe briggs <jbriggs@briggsmedia.com> writes:
> 
> > Can anyone tell me how to absolutely force a reset on a i386?  Specifically, 
> > is there a system call that will call the assembly instruction to assert the 
> > RESET bus line? I try to use the "reboot(LINUX_REBOOT_CMD_RESTART,0,0,NULL)" 
> > call, but it will not always work.  Occassionally, I experience a "missed 
> > interrupt" on a Promise IDE controller, and while I can telnet into the 
> > system, I can't reset it.  Any help greatly appreciated!  Since these systems 
> > are 1000's of miles away, the need to remotely reset it paramont.
> 
> The most reliable way is to force a triple fault; load zero into
> the IDT register and then trigger an exception. The linux kernel 
> does that in fact for reboot and so far I haven't seen any machine failing
> to reset yet.
> 

Except that isn't actually a reset -- it's an INIT, which isn't quite
the same thing; for one thing, the hardware isn't forcibly reset.

On *MOST*, but definitely not ALL, chipsets you can force a "true"
reset by writing 0x06 to I/O port 0x0CF9.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
