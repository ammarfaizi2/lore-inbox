Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290102AbSAKUbm>; Fri, 11 Jan 2002 15:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290100AbSAKUbd>; Fri, 11 Jan 2002 15:31:33 -0500
Received: from adsl-157-194-17.dab.bellsouth.net ([66.157.194.17]:60807 "EHLO
	midgaard.darktech.org") by vger.kernel.org with ESMTP
	id <S290102AbSAKUbV>; Fri, 11 Jan 2002 15:31:21 -0500
Date: Fri, 11 Jan 2002 15:33:41 -0500
From: Andreas Boman <aboman@goofy.nerdfest.org>
To: =?ISO-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 has 2 modules named sym53c8xx.o
Message-Id: <20020111153341.1ebf02a2.aboman@goofy.nerdfest.org>
In-Reply-To: <20020111204356.G1567-100000@gerard>
In-Reply-To: <20020111000052.34204997.aboman@goofy.nerdfest.org>
	<20020111204356.G1567-100000@gerard>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-nerdfest-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 21:01:27 +0100 (CET)
Gérard Roudier <groudier@free.fr> wrote:

> 
> 
> On Fri, 11 Jan 2002, Andreas Boman wrote:
> 
> > It seems a new sym53c8xx was added in 2.4.17, and now there are 2
modules,
> > both named sym53c8xx.o (CONFIG_SCSI_SYM53C8XX and
> > CONFIG_SCSI_SYM53C8XX_2). This was noticed since my mkinitrd script
isn't
> > smart enough to destinguish the two. Leading to the question how does
> > modprobe? Comparing this with the naming scheme used for the two
aic7xxx
> > modules (aic7xxx.o and aic7xxx_old.o) it seems like its a bug to me,
in
> > either case I'd appritiate some input from somebody clued in on the
issue.
> 
> This is a compatibility feature. Just select _the_ driver you want to
use
> but not both. The bug is to build the both drivers without special needs
> or goal.
> 
> Renaming a driver object module will break compatibility of old linux
> installations depending of the driver selected, and also may break
> flexibility for who knows what he is doing.

This is a fine argument, until you consider kernels that arent built
specifically for one platform. I am trying to build a generic kernel that
will work on any supported hardware its loaded on. The documentation for
the new sym53c8xx_2.o driver states: "If your system has problems using
this new major version of the SYM53C8XX driver, you may switch back to
driver version 1."

That one sentence makes me think that the old driver should be renamed
sym53c8xx_old so that both modules can be built and the _old driver loaded
if the new causes any problems.

Further, if you dont rename either of the modules, something should be
done to prevent build of both modules, and/or the documentation (help)
should include a blurb about the modules being named the same thing and
the problems this is bound to cause. As it is there is no indication that
theese modules will be named the same thing, unless you look in the
Makefiles.

> 
> By the way, if it ever happens one of the two modules to be renamed in
> 2.4, it is the old version that will be. As a result, the patch you sent
> me directly that renames the new version is exactly what I donnot want
to
> be done.

Wich is as I suggested should be done. The reason I attached that patch
was just to show that this is an issue that I have had to deal with. And
as I stated, I renamed the new driver since it has the new config option,
and resides in the  drivers/scsi/sym53c8xx_2 subdirectory (and was a much
quicker workaround). 

> 
> In kernel 2.5, SYM53C8XX_2 will replace SYM53C8XX. I already agreed with
> the proposal to remove the old driver version, and I suggested so
> implicitely, obviously, by providing SYM53C8XX_2. I hope this will also
> happen in 2.4 series, but probably a bit later.

Why rename it later (in the 2.4 series) instead of now? The problems
caused by a renaming would occur at that time as well as it would now.

	Andreas
 
>   Gérard.
