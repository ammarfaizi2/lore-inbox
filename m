Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWBCKTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWBCKTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWBCKTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:19:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:8394 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751177AbWBCKTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:19:14 -0500
Date: Fri, 3 Feb 2006 11:18:26 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Adrian Bunk <bunk@stusta.de>, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, kkeil@suse.de,
       Carsten Paeth <calle@calle.in-berlin.de>
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
In-Reply-To: <1138956828.3731.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602031110280.15581@phoenix.one.melware.de>
References: <20060131213306.GG3986@stusta.de>  <1138743844.3968.14.camel@localhost.localdomain>
  <20060202214059.GB14097@stusta.de>  <1138924621.3788.2.camel@localhost.localdomain>
  <Pine.LNX.4.61.0602030941580.13271@phoenix.one.melware.de>
 <1138956828.3731.2.camel@localhost.localdomain>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Marcel Holtmann wrote:
> Hi Armin,
> 
> > > > > > This patch contains the following cleanups:
> > > > > > - move the help text to the right option
> > > > > > - replace some #ifdef's in capi.c with dummy functions in capifs.h
> > > > > > - use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c
> > > > > 
> > > > > I actually still like to see capifs removed completely. It is not really
> > > > > needed if you gonna use udev. The only thing that it is doing, is to set
> > > > > the correct permissions and make sure that the device nodes are created.
> > > > > And with a 2.6 kernel this can be all done by udev.
> > > > 
> > > > udev is not mandatory.
> > > > 
> > > > Static /dev is still 100% supported and working fine.
> > > 
> > > and if you have static /dev then you can use mknod and chown by
> > > yourself. If you use CAPI on any newer distribution with the latest 2.6
> > > kernel you will have udev anyway and so no static /dev at all.
> > 
> > Sorry for my ignorance, but I think capifs was introduced to have own 
> > dynamic 'files' like pts and not to have the restrictions of character 
> > devices and the needed major/minor numbers.
> 
> I am under the impression that it was introduced to change the ownership
> of the device node the current process. Nothing more, nothing less.
> Please correct me if I am wrong here.

I really don't know. Calle should be asked, I think he did that.
  
> > So changing this to character device nodes may break applications
> > out there.
> 
> Actually I stopped compiling in and using capifs over a year ago and I
> never had any problems with it. However you must ensure that the device
> has been created by udev, nut nowadays this is no problem.

I use capi-ppp connections with capifs. If you don't use capifs, how do you
do ppp over CAPI?

What about the major number? Wouldn't we need a major number then?

If udev is creating the device, it may be not existent when the application
expects it. E.g. the application is doing the ioctl to retreive the 
connection number (filename) and expects to be able to open it. But in case 
of udev, it might be not done in that time. So the application needs to wait
for some time..., but how long? I don't like this idea.

Armin
