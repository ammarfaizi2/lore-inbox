Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTKQS2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTKQS2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:28:16 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:921 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S263612AbTKQS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:28:14 -0500
Subject: Re: HOWTO build modules in 2.6.0 ...
From: David T Hollis <dhollis@davehollis.com>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
Content-Type: text/plain
Message-Id: <1069093607.5091.0.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Nov 2003 13:28:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 14:00, Wojciech 'Sas' Cieciwa wrote:
> Hi,
> 
> How can I build kernel modele from other package without root, or copying 
> all from /usr/scr/linux/ ??
> When I try build kernel module from user i got error,
> 
> [...]
> make[1]: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'
> /usr/bin/make -C /usr/src/linux SUBDIRS=`pwd` modules;
> make[1]: Entering directory `/usr/src/linux-2.6.0'
>   HOSTCC  scripts/fixdep
> cc1: Permission denied: opening dependency file scripts/.fixdep.d
> make[2]: *** [scripts/fixdep] Error 1
> make[1]: *** [scripts] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.0'
> make: *** [adiusbadsl.o] Error 2
> make: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'
> 
> How can I solve this problem ??
> 
> Thanx,
> 					Sas.

Here's what I have used that works quite well.  Taken from the lwn.net
articles on porting to 2.5/2.6:


ifneq ($(KERNELRELEASE),)
obj-m   := usbnet.o
 
else
KDIR    := /lib/modules/$(shell uname -r)/build
PWD     := $(shell pwd)
 
default:
        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
endif


The only item to change would be the 'obj-m := usbnet.o'.  That's the
module that you want built.

