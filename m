Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSGZC1e>; Thu, 25 Jul 2002 22:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSGZC1e>; Thu, 25 Jul 2002 22:27:34 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:60318 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316705AbSGZC1d>; Thu, 25 Jul 2002 22:27:33 -0400
Date: Thu, 25 Jul 2002 21:30:41 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pat Suwalski <pats@xandros.com>
cc: henrique@cyclades.com, <linux-kernel@vger.kernel.org>
Subject: Re: modversion clarification.
In-Reply-To: <3D4038CF.4020501@xandros.com>
Message-ID: <Pine.LNX.4.44.0207252122510.384-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Pat Suwalski wrote:

> henrique wrote:
> > When you try to load the module, the insmod will check if the symbols of your 
> > module are the same of the current running kernel. If the symbols are the 
> > same the module will be loaded. So you can use your module on all kernels 
> > that have the same CRC for the kernel functions your module uses.

Yes, provided that module and kernel have the same version string 
("2.4.18-preX").

> So then is that not opposite of what modversion says it does, which is 
> to allow modules to be more comptible across multiple kernel versions?

No. If you enable modversions, that will always cause stricter checking - 
without modversions, basically only the comparison of the version string 
protects you from inserting an incompatible module. If you have 
modversions enabled, the generated checksums provide additional checking 
for mismatching ABIs (interfaces).

> Basically, the problem is that if module.h is included and MODVERSION is 
> not defined, and the module wants to export symbols (EXPORT_SYMTAB is 
> defined), then module.h automatically ifdefs modversions.h even if the 
> kernel is not configured to use it (and thus the file does not exist).

The build process in 2.4 will generate a modversions.h file no matter what 
CONFIG_MODVERSION says (but it'll be empty if it's switched off). For some 
insight in what magic happens I put a lengthy comment into the 2.5 version 
of include/linux/module.h - "So how does the CONFIG_MODVERSIONS magic 
work?", if you're interested you may want to check that out.

--Kai


