Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTJGQD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTJGQD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:03:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21068 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262446AbTJGQDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:03:23 -0400
Date: Tue, 7 Oct 2003 09:03:20 -0700 (PDT)
From: Tigran Aivazian <tigran@veritas.com>
To: Maciej Zenczykowski <maze@cela.pl>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Giacomo A. Catenazzi" <cate@debian.org>,
       <linux-kernel@vger.kernel.org>, <simon@urbanmyth.org>
Subject: RE: RFC: changes to microcode update driver.
In-Reply-To: <Pine.LNX.4.44.0310071747030.31485-100000@gaia.cela.pl>
Message-ID: <Pine.GSO.4.44.0310070901010.23226-100000@south.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Maciej Zenczykowski wrote:

> > As Tigran pointed out, we are active in this area too. At this point we
> > want to add support of the extended update format to the driver, before
> > we ship the latest microcode data. Some of them require the new format.
>
> Do we even have any use for a userspace utility anymore?
> strace'ing the microcode_ctl -u process results in information that the
  ~~~~~~~~~~

If you read the code instead of stracing you would have discovered that
there is a little (i.e. undocummented :) switch to do everything you
described below.

As for compiling the microcode data into the kernel (as scsi firmware etc)
I recall that Alan Cox said we are moving away from that sort of thing,
so it's not a good idea.

Kind regards.
Tigran

> microcode.dat file is converted to binary and written to
> /dev/cpu/microcode.  The following code:
> #include <stdio.h>
> int main (void) {
>   int x[4], i;
>   while ((i = scanf("%x, %x, %x, %x,\n", &x[0], &x[1], &x[2], &x[3])) > 0)
> fwrite(x, 4, i, stdout);
>   return 0;
> };
> does the conversion to binary:
> cat /etc/microcode.dat | grep -v "^/" | ./a.out > microcode.raw
> and the following loads it:
> dd bs=`ls -s --block-size=1 microcode.raw | cut -f 1 -d " "`
> if=microcode.raw of=/dev/cpu/microcode
>
> Either distribute the microcode in binary form and load it via dd (in the
> /etc/rc.d/init.d/microcode script)
> or include the text file parser in the microcode module - since the module
> is only needed during loading of the update this tiny amount of extra code
> is likely acceptable.  For reducing kernel size for embedded systems (any
> based on ia32 lacking the few kb?) try compiling the 2kb update relevant
> for the given processor directly into the kernel...
>
> Just a few ideas...
>
> MaZe.
>
>

