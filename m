Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUFOTU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUFOTU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUFOTU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:20:26 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:29618 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265878AbUFOTUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:20:20 -0400
Message-ID: <40CF4C48.5A317311@users.sourceforge.net>
Date: Tue, 15 Jun 2004 22:21:44 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] kbuild: external module build doc
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204809.GF15243@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> --- /dev/null   Wed Dec 31 16:00:00 196900
> +++ b/Documentation/kbuild/extmodules.txt       2004-06-14 22:25:21 +02:00
[snip]
> +A more advanced example
> +- - - - - - - - - - - -
> +This example shows a setup where a distribution has wisely decided
> +to separate kernel source and output files:
> +
> +Kernel src:
> +/usr/src/linux-<kernel-version>/
> +
> +Output from a kernel compile, including .config:
> +/lib/modules/linux-<kernel-version>/build/
                                       ^^^^^
Wrong! The 'build' symlink has always pointed to kernel source dir in
separate source and object directory case. Maybe you meant:

Output from a kernel compile, including .config:
/lib/modules/linux-<kernel-version>/object/
                                    ^^^^^^
> +External module to be compiled:
> +/home/user/module/src/
> +
> +To compile the module located in the directory above use the
> +following command:
> +
> +       cd /home/user/module/src
> +       make -C /usr/src/linux-<kernel-version> \
> +       O=/lib/modules/linux-<kernel-version>/build \
                                                ^^^^^
O=/lib/modules/linux-<kernel-version>/object
                                      ^^^^^^
> +       M=`pwd`
> +
> +Then to install the module use the following command:
> +
> +       make -C /usr/src/linux-<kernel-version> \
> +               O=/lib/modules/linux-<kernel-version>/build \
                                                        ^^^^^
O=/lib/modules/linux-<kernel-version>/object
                                      ^^^^^^
> +               M='pwd` modules_install
[snip]
> +Prepare the kernel for building external modules
> +------------------------------------------------
> +When building external modules the kernel is expected to be prepared.
> +This includes the precense of certain binaries, the kernel configuration
> +and the symlink to include/asm.
> +To do this a convinient target is made:
> +
> +       make modules_prepare
> +
> +For a typical distribution this would look like the follwoing:
> +
> +       make modules_prepare O=/lib/modules/linux-<kernel version>/build
                                                                     ^^^^^
make modules_prepare O=/lib/modules/linux-<kernel version>/object
                                                           ^^^^^^
Sam, You don't seem to have any idea how much breakage you introduce if you
insist on redirecting the 'build' symlink from source tree to object tree.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
