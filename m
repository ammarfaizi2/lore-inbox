Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUDKSnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 14:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUDKSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 14:43:24 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:17311 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262442AbUDKSnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 14:43:22 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: linux-kernel@vger.kernel.org
Subject: kernelversion distinction (was 2.6.5 - incomplete headers?)
Date: Sun, 11 Apr 2004 20:33:19 +0200
User-Agent: KMail/1.5.4
References: <200404111327.19744.aweiss@informatik.hu-berlin.de> <40793189.3070403@portrix.net>
In-Reply-To: <40793189.3070403@portrix.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404112033.20025.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 11. April 2004 13:52 schrieb Jan Dittmer:
> Axel Weiss wrote:
> > Hi,
> >
> > I'm going to bring my device drivers[1] from 2.4 to 2.6 and have
> > successfully installed kernel-2.6.5 for my athlon-PC.
> >
> > (Where is the starting point to read, in this case?)
>
> LWN has quite a collection:
>
> http://lwn.net/Articles/driver-porting/
Thanks, very helpful!

Now, I`m trying to be compatible with older kernels (2.2 - 2.4) and want to 
find out what kernel version ist installed, from Makefile. My first solution:

# Makefile
KERNELVERSION := $(shell uname -r)
KERNELBASE    := $(basename $(KERNELVERSION))
KERNELMINOR   := $(suffix $(KERNELBASE))
KERNELMAJOR   := $(basename $(KERNELBASE))

OLD_MODULES := $(strip $(foreach V, .0 .1 .2 .3 .4, $(shell [ "$(V)" = 
"$(KERNELMINOR)" ] && echo yes)))

ifeq ($(KERNELMAJOR),2)
ifeq ($(OLD_MODULES),yes)
#	old style make
endif #ifeq ($(OLD_MODULES),yes)
#	new style make, like pointed out in LWN
else #ifeq ($(KERNELMAJOR),2)
all:
	@echo kernel $(KERNELVERSION) not supported
endif #ifeq ($(KERNELMAJOR),2)

Any improvements? Up to which kernel version should old style make be used?

Regards,
Axel Weiss

