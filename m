Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRKITRK>; Fri, 9 Nov 2001 14:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKITRA>; Fri, 9 Nov 2001 14:17:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33036 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280029AbRKITQu>; Fri, 9 Nov 2001 14:16:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: serial console slow
Date: 9 Nov 2001 11:16:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9sha2j$l5l$1@cesium.transmeta.com>
In-Reply-To: <20011109102140.A29288@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011109102140.A29288@elf.ucw.cz>
By author:    root <root@Elf.ucw.cz>
In newsgroup: linux.dev.kernel
> 
> Hi!
> 
> > I tried to boot my kernel using the serial console, using the
> > console=ttyS0,115200 (it does the same thing with 9600) ... it work great
> > until :
> > 
> > Freeing unused kernel memory: 36k freed
> > serial console detected.  Disabling virtual terminals.
> > console=/dev/ttyS0
> > 
> > At this point the output of the serial line slow down dramaticly ... almost
> > to a halt ... I get 1 line every 30 seconds !!!
> > 
> > why is this slow down occuring ? the part which is 100% kernel is going fast
> > and ok, but when it become console related ... it slows down ?
> 
> Serial just got its control signals (it is now *userland* writing, and
> userland honours them), plus userland is  probably opening/closing
> serial all the time. Bad.
> 									Pavel

I have had much better luck talking to /dev/console in userland.
IMNSHO this should *always* work; anything else is broken.
/dev/console currently *IS* broken to some degree, multi-console
hasn't worked properly for a long time, and you don't get job control
running of it because it isn't a tty, but I think it's a lot less
broken than things like the above...

(And dammit, I really would like to see console=tty0 console=ttyS0 to
actually give me both consoles -- in userland *and* in the kernel...)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
