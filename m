Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289163AbSAJEtA>; Wed, 9 Jan 2002 23:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289165AbSAJEsu>; Wed, 9 Jan 2002 23:48:50 -0500
Received: from mail.broadpark.no ([217.13.4.2]:30921 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S289163AbSAJEse>;
	Wed, 9 Jan 2002 23:48:34 -0500
Date: Thu, 10 Jan 2002 05:45:55 +0100
From: jon svendsen <jon-sven@frisurf.no>
To: linux-kernel@vger.kernel.org
Subject: xfree86 compilation failure due to naming conflict (linux 2.4.17, Xfree86 4.1.0)
Message-ID: <20020110054555.C4116@fig.aubernet>
In-Reply-To: <20020110053949.A4116@fig.aubernet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020110053949.A4116@fig.aubernet>; from jon-sven@frisurf.no on Thu, Jan 10, 2002 at 05:39:49 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.01.10 05:39 jon svendsen wrote:
Hello,

The SiS DRM drivers in the 2.4.17 linux kernel has caused the 
possibility of failure to compile xfree86 4.1.0 (and CVS). The cause of 
the conflict is the definition of CONFIG_DRM_SIS, used both in kernel 
configuration and in the xfree86 DRM code.

If DRM is enabled in the kernel (CONFIG_DRM) but the SiS driver is 
disabled or configured as a module, <linux/autoconf.h>, included from 
<linux/config.h>, will contain an #undef CONFIG_DRM_SIS.

<linux/config.h> is included from 
xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm.h in the 
xfree86 source tree. The file 
xc/programs/Xserver/hw/xfree86/os-support/linux/drm/xf86drmSiS.c does a 
#define CONFIG_DRM_SIS prior to including this file in order to have 
necessary parts of it included.

It flows something like this:

xf86drmSiS.c:
#define CONFIG_DRM_SIS
#include "drm.h"

drm.h:
#include <linux/config.h> // #undef CONFIG_DRM_SIS

#ifdef CONFIG_DRM_SIS
// stuff necessary for compilation of xf86drmSiS.c
#endif

And compilation of xf86drmSiS.c fails.

I'd supply a patch, but I'm not familiar enough with the relationship 
between the kernel and xfree86 drivers to know what the proper solution 
would be, nor am I certain if the modification should happen in linux 
or in xfree86. Hopefully I have supplied enough information facilitiate 
a fairly simple solution.

Jon Svendsen
--- Sorcerer GNU Linux (http://sorcerer.wox.org)



