Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264586AbUD1Bdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUD1Bdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUD1BdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:33:21 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:8597 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264578AbUD1BdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:33:08 -0400
Date: Wed, 28 Apr 2004 03:33:05 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Tim Hockin <thockin@hockin.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <20040428011348.GA22754@hockin.org>
Message-ID: <Pine.LNX.4.44.0404280317290.17647-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Tim Hockin wrote:

> On Wed, Apr 28, 2004 at 02:56:16AM +0200, Robert M. Stockmann wrote:
> > > Care to show me where they use unnamed structures, and how it has anything
> > > to do with binary modules?
> > 
> > fasttrak.h :
> > #define ft3xx {							\
> > 	next: NULL,						\
> 	...
> > } 
> > #endif
> 
> > This header file is needed to be able to link ft3xx.o . In which way binary 
> > incompatibility is introduced, inside this case is hard to tell. We
> > will never know i guess , since the type and size of the above components
> > is hidden inside the binary only part :
> 
> Do you know C, or just pretend to?

I am no kernel coder, if its that what you mean. 

> 
> Those are structure initializers, not unnamed types.  They've provided a
> macro to use to initialize instances of some structure.
> 
> fasttrak.c:890 shows
> 	static Scsi_Host_Template driver_template = ft3xx;
> 
> The structure definition for 'Scsi_Host_Template' is in
> /usr/src/linux/drivers/scsi/hosts.h which is included in fasttrak.c.

Ok you got me there. I would suggest to change fasttrak.h like this
to obtain better readability :

#ifndef _ft3xx_h
#define _ft3xx_h

#include <linux/version.h>
#include "/usr/src/linux/drivers/scsi/hosts.h"

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
#define ft3xx {                                                 \
        next: NULL,                                             \
	...
};

> 
> If you run it thru the preprocessor, you'd see
> 	static Scsi_Host_Template driver_template = {
> 		next: NULL,
> 		...
> 	};
> 
> No opaque structs.  No unnamed types.  No magic.  It's not pretty, and
> it's bound to break on any non-standard rig, but it's NOT what you claim
> it is.
> 
> The initializer style (foo:  value) is probably why gcc-2.95 blows up, but
> I don't have it here to verify.

It does, which awakened me all up in arms. certainly if gcc-2.95.3
is still mentioned as recommended gcc version for the ia32 platform 
inside /usr/src/linux/Documentation/Changes. It pissed me off not
being able to use gcc-2.95.3 when using that fasttrak driver.

> 
> You really should know what you're talking about before you launch a
> crusade against something.
> 

I agree the fasttrak partial-source kit is not the all defining example.
Still i believe nasty stuff is possible.

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

