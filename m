Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRBFJE4>; Tue, 6 Feb 2001 04:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129924AbRBFJEr>; Tue, 6 Feb 2001 04:04:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:16132 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129657AbRBFJEb>;
	Tue, 6 Feb 2001 04:04:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John R Lenton <john@grulic.org.ar>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops on UHCI module unload (2.4.2-pre1) 
In-Reply-To: Your message of "Tue, 06 Feb 2001 05:40:40 -0300."
             <20010206054040.B692@grulic.org.ar> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 20:04:24 +1100
Message-ID: <3630.981450264@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001 05:40:40 -0300, 
John R Lenton <john@grulic.org.ar> wrote:
>When trying to figure out how to get USB to work (it was the MPS
>setting, more in other post) I got a repeatable Oops (is it an
>oops? it doesn't say "Oops!" like I thought they do).

The kernel makes you guess what the error messages are, to add some
spice to life :-)

>Attached are two ksymoops outputs, for the two times I did this.

  Error (expand_objects): cannot stat(/lib/modules/2.4.2-pre1/kernel/drivers/usb/uhci.o) for uhci
  Error (expand_objects): cannot stat(/lib/modules/2.4.2-pre1/kernel/drivers/usb/usbcore.o) for usbcore
  Error (expand_objects): cannot stat(/lib/modules/2.4.2-pre1/kernel/drivers/input/mousedev.o) for mousedev
  Error (expand_objects): cannot stat(/lib/modules/2.4.2-pre1/kernel/drivers/input/input.o) for input
  Feb  4 04:32:20 burocracia kernel: Unable to handle kernel paging request at virtual address d10ff9e8

ksymoops could not find the modules you loaded.  Did you rename, delete
or overwrite /lib/modules/2.4.2-pre1 between the oops and the time you
ran ksymoops?

  Error (expand_objects): cannot stat(/lib/modules/2.4.2-pre1/kernel/drivers/usb/uhci.o) for uhci
  Error (expand_objects): cannot stat(/lib/modules/2.4.2-pre1/kernel/drivers/usb/usbcore.o) for usbcore
  Warning (expand_objects): object /lib/modules/2.4.2-pre1/kernel/drivers/net/ppp_deflate.o for module ppp_deflate has changed since load
  Warning (expand_objects): object /lib/modules/2.4.2-pre1/kernel/drivers/net/bsd_comp.o for module bsd_comp has changed since load
  Warning (expand_objects): object /lib/modules/2.4.2-pre1/kernel/drivers/net/ppp_async.o for module ppp_async has changed since load
  Warning (expand_objects): object /lib/modules/2.4.2-pre1/kernel/drivers/net/ppp_generic.o for module ppp_generic has changed since load
  Warning (expand_objects): object /lib/modules/2.4.2-pre1/kernel/drivers/net/slhc.o for module slhc has changed since load

ksymoops could could not find some modules, those it could find have
changed since the oops.  I would treat all your traces with suspicion,
the base data is very unreliable.  Try to reproduce with current
modules, instead of modules that have changed since the oops.

BTW, do not specify -O unless you have a good reason to ignore objects,
which you don't.  You should supply a system map with -m instead of
suppressing it with -M.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
