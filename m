Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbUKVR0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbUKVR0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUKVRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:25:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54276 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262241AbUKVRUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:20:01 -0500
Date: Mon, 22 Nov 2004 18:19:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-ID: <20041122171956.GI19419@stusta.de>
References: <20041121220251.GE13254@stusta.de> <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de> <1101140745.9784.7.camel@uganda> <20041122165145.GH19419@stusta.de> <1101143109.9784.9.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101143109.9784.9.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:05:09PM +0300, Evgeniy Polyakov wrote:
> On Mon, 2004-11-22 at 17:51 +0100, Adrian Bunk wrote:
> > On Mon, Nov 22, 2004 at 07:25:45PM +0300, Evgeniy Polyakov wrote:
> > > 
> > > > How would a different w1 bus master chip look like in 
> > > > drivers/w1/Makefile?
> > > 
> > > obj-m: proprietary_module.o
> > > proprietary_module-objs: dscore.o proprietary_module_init.o
> > > 
> > > Actually it will live outside the kernel tree, but will require ds2490
> > > driver.
> > > It could be called ds2490.c but I think dscore is better name.
> > 
> > Why are you talking about proprietary modules living outside the kernel 
> > tree?
> > 
> > The only interesting case is the one of modules shipped with the kernel.
> > And for them, this will break at link time if two such modules are 
> > included statically into the kernel.
> 
> If we _currently_ do not have any open hw/module that depends on ds2490
> core then it does not
> mean that tomorrow noone will add it.

Once again:
  _this will break at link time if two such modules are included 
   statically into the kernel_

obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
ds9490r-objs    := dscore.o

obj-$(CONFIG_W1_FOO)         += foo.o 
foo-objs    := dscore.o


This will break with CONFIG_W1_DS9490=y and CONFIG_W1_FOO=y.


That drivers/w1/ contains many EXPORT_SYMBOL's with no in-kernel users 
is a different issue I might send a separate patch for (that besides 
proprietary modules there might come some day open source drivers using 
them is not a reason).


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

