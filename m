Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262104AbREPWOh>; Wed, 16 May 2001 18:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbREPWO2>; Wed, 16 May 2001 18:14:28 -0400
Received: from comverse-in.com ([38.150.222.2]:17028 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S262104AbREPWOP>; Wed, 16 May 2001 18:14:15 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678ED5@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ((struct pci_dev*)dev)->resource[...].start
Date: Wed, 16 May 2001 18:13:28 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
Many thanks for the clarifications.

> From: Jeff Garzik
> "Khachaturov, Vassilii" wrote:
[snip]
> > bootup, the mapping of the PCI base address registers to 
> virtual memory will
> > remain the same (just as seen in /proc/pci, and as 
> reflected in <subj>)? If
> > not, is there a way to freeze it for the time I want to access it?
> 
> This is not a safe assumption, because the OS may reprogram 
> the PCI BARs
> at certain times.  The rule is:  ALWAYS read from 
> dev->resource[] unless
> you are a bus driver (PCI bridges, for example, need to assign
> resources).
[snip]

I am not a bus driver, and I do call pci_enable_device once my device gets 
probed and recognized by my driver. I always read from dev->resource[].
But what are the "certain times" you've mentioned? What is the scope
within which I know the BARs didn't change?
 
> Finally, make sure to use pci_resource_{start,end,len,flags} macros to
> make your core more portable and future-proof.
I didn't use the macros - now I do, thanks for the tip!

> > 2) (Basically, the question is "Do I understand 
> Documentation/IO-mapping.txt
> > right?")
> > PCI memory, whenever IO type or memory type, can not be 
> dereferenced but
> > should be accessed with readb() etc. On i386, PCI mem 
> (memory type) can be
> > accessed by direct pointer access, but this is not portable.
> 
> We will yell at you mightily if you directly access PCI mem with a
> pointer.  As you say it only works on i386 -- but IIRC since 

Right now I am porting a driver to Linux which has so much i386 things in it

(esp. byte order stuff). So far I haven't spoilt it with PCI i386 hacks
though...

> ioremap is
> required, we are perfectly free to change or modify that assumption. 
> For example ioremap might [have to] care about whether or not 
> a pci mem
> region is prefetchable.

A really silly q. (I don't quite understand the Linux internals yet):
Is ioremap() needed (in general vs. i386) for memory type PCI memory too, 
or only for IO type?
(In case the default size of the region associated with a BAR is fine with
me?)

Thanks,
	Vassilii
