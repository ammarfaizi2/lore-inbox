Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTJXQuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTJXQuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:50:21 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:19896 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262406AbTJXQuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:50:16 -0400
Date: Fri, 24 Oct 2003 12:50:11 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Copying .config to /lib/modules/`uname -r`/kernel
In-Reply-To: <20031024155343.GP5017@actcom.co.il>
Message-ID: <Pine.LNX.4.56.0310241234010.1701@marabou.research.att.com>
References: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan>
 <20031024155343.GP5017@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003, Muli Ben-Yehuda wrote:

> On Fri, Oct 24, 2003 at 04:26:12AM -0400, Pavel Roskin wrote:
>
> > Cannot we just install .config to the same directory as modules?  If
>
> What's wrong with /lib/modules/version/build/.config?

It's missing on Red Hat Linux.  The reason if that there are differently
configured kernels (e.g. SMP, high memory) that have different binary
packages.  On the other hand, there is just one source package. Binary
packages cannot install .config to the same place, or they will conflict.
That's why they put .config under the name /boot/config/`uname -r` in
every binary package.  Kernel versions include the configuration, so these
files don't conflict.

Using /boot is not standard across distributions.  I think Linux
developers should be the ones who set standard.  If it's /boot then fine,
but .config should be installed somewhere for reference.

Alternatively, there should be some way to extract .config from files
compiled with CONFIG_IKCONFIG.  However, I would prefer a plain text file
that could be used by simply adding "include" in the Makefile.

> you need the build symlink to compile a module against this kernel
> anyway, because you need its includes, not to mention its build system.

The includes are there.  Only autoconf.h needs to be recreated.

-- 
Regards,
Pavel Roskin
