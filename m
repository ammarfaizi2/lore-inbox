Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317663AbSFRXFN>; Tue, 18 Jun 2002 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317664AbSFRXEQ>; Tue, 18 Jun 2002 19:04:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:25326 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317663AbSFRXEN>; Tue, 18 Jun 2002 19:04:13 -0400
Date: Wed, 19 Jun 2002 01:04:07 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Greg KH <greg@kroah.com>
cc: Matthew Harrell 
	<mharrell-dated-1024798178.8a2594@bittwiddlers.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 fix for pci_hotplug
In-Reply-To: <20020618215549.GG21229@kroah.com>
Message-ID: <Pine.NEB.4.44.0206190101020.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Greg KH wrote:

> On Mon, Jun 17, 2002 at 10:09:37PM -0400, Matthew Harrell wrote:
> >
> > --- linux/drivers/hotplug/pci_hotplug_core.c-ori	Mon Jun 17 22:01:17 2002
> > +++ linux/drivers/hotplug/pci_hotplug_core.c	Mon Jun 17 22:03:33 2002
> > @@ -183,13 +183,13 @@
> >  /* default file operations */
> >  static ssize_t default_read_file (struct file *file, char *buf, size_t count, loff_t *ppos)
> >  {
> > -	dbg ("\n");
> > +	dbg ("%s", "\n");
>
> <snip>
>
> What problem does this fix?
>...

He tries to fix the following compile error that is caused by Martin
Dalecki's "[PATCH] 2.5.21 kill warnings 4/19" that is included in 2.5.22:

<--  snip  -->

...
  gcc -Wp,-MD,./.pci_hotplug_core.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5
/linux-2.5.22-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6 -nostdinc -iwithprefix include
-DKBUILD_BASENAME=pci_hotplug_core   -c -o pci_hotplug_core.o pci_hotplug_core.c
pci_hotplug_core.c: In function `default_read_file':
pci_hotplug_core.c:186: parse error before `)'
pci_hotplug_core.c: In function `default_write_file':
pci_hotplug_core.c:192: parse error before `)'
pci_hotplug_core.c: In function `pcihpfs_create_by_name':
pci_hotplug_core.c:420: parse error before `)'
pci_hotplug_core.c: In function `power_read_file':
pci_hotplug_core.c:540: parse error before `)'
pci_hotplug_core.c: In function `power_write_file':
pci_hotplug_core.c:581: parse error before `)'
pci_hotplug_core.c: In function `attention_read_file':
pci_hotplug_core.c:651: parse error before `)'
pci_hotplug_core.c: In function `attention_write_file':
pci_hotplug_core.c:692: parse error before `)'
pci_hotplug_core.c: In function `latch_read_file':
pci_hotplug_core.c:744: parse error before `)'
pci_hotplug_core.c: In function `presence_read_file':
pci_hotplug_core.c:788: parse error before `)'
pci_hotplug_core.c: In function `test_write_file':
pci_hotplug_core.c:829: parse error before `)'
pci_hotplug_core.c: In function `pci_hotplug_init':
pci_hotplug_core.c:1073: parse error before `)'
make[2]: *** [pci_hotplug_core.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.22-full/drivers/hotplug'

<--  snip  -->

> thanks,
>
> greg k-h

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



