Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSKXPWy>; Sun, 24 Nov 2002 10:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSKXPWy>; Sun, 24 Nov 2002 10:22:54 -0500
Received: from services.cam.org ([198.73.180.252]:5910 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261365AbSKXPWx>;
	Sun, 24 Nov 2002 10:22:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: Invalid module format - how does one fix this?
Date: Sun, 24 Nov 2002 10:30:07 -0500
User-Agent: KMail/1.4.3
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
References: <200211241450.gAOEosO10740@localhost.localdomain>
In-Reply-To: <200211241450.gAOEosO10740@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211241030.07212.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 24, 2002 09:50 am, J.E.J. Bottomley wrote:
> > 2.5.49-mm1 works ok here (shpte enabled too).  I see two frustrating
> > problems left with the modules change (user perspective).  The most
> > irratating one is messages like:
> >
> > FATAL: Error inserting /lib/modules/2.5.49-mm1/kernel/ac97_codec.o:
> > Invalid module format
> >
> > I get this on about 10% of the modules I want to load.  How do I fix
> > it?
>
> It seems that the new module loader *requires* init routines (they were
> optional on the old one) so a lot of modules that are simply helper
> routines and didn't previously have an init now need one.
>
> I fixed this on my 53c700.c library module by adding
>
> no_module_init;
>
> at the end of the file.
>
> > The second is that automatic loading is not working.  Manually loading
> > modules is a PITA. What plans are there to fix this?
>
> This hasn't annoyed me enough that I've looked into it yet.  I suspec the
> new modprobe doesn't know about the in-kernel module names (or to look in
> /etc/modules.conf) yet.

Thanks James.  Including init.h and adding no_module_init fixes ac97_codec.
Now to see if the matrox fb stuff also can be fixed.

Ed Tomlinson
