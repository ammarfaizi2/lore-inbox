Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281054AbRKKNHi>; Sun, 11 Nov 2001 08:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKKNHS>; Sun, 11 Nov 2001 08:07:18 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:44558 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281054AbRKKNHK>;
	Sun, 11 Nov 2001 08:07:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: dalecki@evision.ag
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current" 
In-Reply-To: Your message of "Sun, 11 Nov 2001 14:16:36 BST."
             <3BEE7A34.BF9526FB@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Nov 2001 00:06:57 +1100
Message-ID: <28521.1005484017@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001 14:16:36 +0100, 
Martin Dalecki <dalecki@evision-ventures.com> wrote:
>I have now a nice kernel at home, compiled with -mredparm=3 up
>... Patch will follow on monday

Compiling the kernel with mregparm is going to play havoc with binary
only modules (BOMs), interface mismatches all over the place.  I know
we do not support BOMs but there is a big difference between not
supporting them and having them actively destroy the kernel because of
different calling sequences.

A new feature of kbuild 2.5 is defining which CONFIG options are
critical, any change to any critical config option forces a complete
kernel rebuild.  Modutils 2.5 will also refuse to load a module if its
critical config options are different from the kernel.  The current
list of critical options is

  CONFIG_SMP
    UP modules in SMP kernel or vice versa just go splat.  This
    replaces the modversions '_smp' prefix.

  CONFIG_KBUILD_GCC_VERSION
    Inserting a module compiled with gcc 3.0.1 into a kernel compiled
    with gcc 3.0.2 is a receipe for disaster.  Kernel and module must
    be built with the same compiler.

Any changes that affect the ABI for modules must be handled via config
options and those options must be on the critical list in 2.5.

Please add CONFIG_MREGPARM with a huge warning that, until kbuild 2.5
and modutils 2.5 are available, inserting a BOM is likely to destroy a
kernel compiled with CONFIG_MREGPARM.

