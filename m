Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRCTPX3>; Tue, 20 Mar 2001 10:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRCTPXT>; Tue, 20 Mar 2001 10:23:19 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:45242 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S130384AbRCTPXC>; Tue, 20 Mar 2001 10:23:02 -0500
Message-ID: <3AB77485.3BAB3AFE@oracle.com>
Date: Tue, 20 Mar 2001 16:17:25 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, tytso@mit.edu,
        guthrie@infonautics.com
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <Pine.LNX.3.96.1010320080638.18764C-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> On Tue, 20 Mar 2001, Alessandro Suardi wrote:
> > Jeff Garzik wrote:
> > > Neither.  serial.c does serial_cb's job now.  It looks like serial.c
> > > needs to scan for modems as well as serial ports, and tytso agrees with
> > > me on that.  We just need to check and see if winmodems reports
> > > themselves as real modems before fixing this.
> 
> > OK, thanks. I assume you mean "serial.c should do serial_cb's job now",
> >  since it doesn't :) If you want me to test patches etc. just let me know.
> 
> Re-CC'd to linux-kernel, hope you don't mind.

No problem for me, of course.

> Anyone interested in testing patches, this simple change is what needs
> testing on various PCI and CardBus modems:
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg34097.html
> (since it's a web archive, you may have to hack the patch in manually...)

I performed this hand-diff...

[asuardi@princess char]$ diff serial.c serial.c-2.4.3p4 
4613,4614c4613
< 	if (!((dev->class >> 8) == PCI_CLASS_COMMUNICATION_SERIAL ||
< 			(dev->class >> 8) == PCI_CLASS_COMMUNICATION_MODEM) ||
---
> 	if ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL ||

...and still my Xircom modem tty isn't detected :(

> It seems straightforward enough, and both tytso and I think the change
> is ok, but (at tytso's suggestion) I'm going to test some various
> winmodem and other use cases because assuring ourselves that it is good
> enough for a general rule...

Available for further testing (or fixing my diff if I patched it badly).


Thanks & ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p17/2.4.3p4 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.

