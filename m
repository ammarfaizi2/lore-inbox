Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbTAOKj3>; Wed, 15 Jan 2003 05:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTAOKj3>; Wed, 15 Jan 2003 05:39:29 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:2006 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S266218AbTAOKj2>; Wed, 15 Jan 2003 05:39:28 -0500
Date: Wed, 15 Jan 2003 11:48:14 +0100
From: Brice Goglin <bgoglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Cc: john stultz <johnstul@us.ibm.com>
Subject: Dealing with 2.5.x subarch headers
Message-ID: <20030115104814.GA4734@ens-lyon.fr>
References: <20030109163208.GG30490@ens-lyon.fr> <1042139980.1050.182.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1042139980.1050.182.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a module for 2.5.x. My module requires
something like irq_vectors.h.
Due do previous messages about this and John Stultz'
subarch cleanup patch (merged in 2.5.53), I finally
added "-Iinclude/asm/mach-default" to gcc options.

Talking to John about a way to find an easy solution
for module developers to get the good -I options, he
proposed to add something like this to the Makefile.

#Subarch selection
mflags-$(CONFIG_X86_VOYAGER)    := -Iinclude/asm-i386/mach-voyager
mflags-$(CONFIG_X86_VISWS)      := -Iinclude/asm-i386/mach-visws
mflags-$(CONFIG_X86_NUMAQ)      := -Iinclude/asm-i386/mach-numaq
# default subarch .h files
mflags-y += -Iinclude/asm-i386/mach-default
CFLAGS += $(mflags-y)
AFLAGS += $(mflags-y)

I was wondering if a easiest way could be found.
Forcing module developers to add something like this looks
to much complicated for me.

The way the "asm" symbolic link hides kernel arch config
looks pretty.
Maybe we could hide subarch config with a symbolic link
pointing to the good asm/mach-xyz.

But the current i386 subarch organization requires to include
both the generic asm-i386/mach-default and a specific
asm-i386/mach-xyz (voyager or ...).

A solution could be to create a symbolic link "mach-specific"
pointing the specific "mach-xyz" and then include both
asm/mach-default and asm/mach-specific.
(Yes, it would require a few updates in all other archs
which do not have any subarch).

Any simple idea ?
Maybe the subarch organization needs some more cleanups ?

Regards

Brice Goglin
==============================================
Ph.D Student
Laboratoire de l'Informatique du Parallélisme
ENS Lyon - France
