Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTLFAvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTLFAvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:51:04 -0500
Received: from gizmo07bw.bigpond.com ([144.140.70.17]:13720 "HELO
	gizmo07bw.bigpond.com") by vger.kernel.org with SMTP
	id S264881AbTLFAvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:51:01 -0500
Message-ID: <3FD127F2.48A190E5@eyal.emu.id.au>
Date: Sat, 06 Dec 2003 11:50:58 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 - scsi/pcmcia qlogic still does not build (m)
References: <20031205022225.GA1565@dualathlon.random> <3FD07392.A47A0A6D@eyal.emu.id.au> <20031205230922.GF2121@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Fri, Dec 05, 2003 at 11:01:22PM +1100, Eyal Lebedinsky wrote:
> > Andrea Arcangeli wrote:
> > >
> > > This should be the last 2.4-aa kernel ;)
> >
> > I guess nobody volunteered to fix it since -pre6aa2...
> >
> > It builds just fine in vanilla 2.4.23.
> 
> is the error still the same as in your email with ID
> 20031002152648.GB1240@velociraptor.random right?

Yes, problem with module_init. Same with fdomain etc..

I disabled the subsystem in order to complete the build.

Here is an example of the failure (for another module in this
subsystem):

ld -m elf_i386 -r -o aha152x_cs.o aha152x_stub.o aha152x.o
aha152x.o: In function `init_module':
aha152x.o(.text+0x50f0): multiple definition of `init_module'
aha152x_stub.o(.text+0x740): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
aha152x.o
aha152x.o: In function `cleanup_module':
aha152x.o(.text+0x5130): multiple definition of `cleanup_module'
aha152x_stub.o(.text+0x790): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
aha152x.o
make[3]: *** [aha152x_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-aa/drivers/scsi/pcmcia'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
