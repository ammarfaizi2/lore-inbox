Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUCGSdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 13:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUCGSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 13:33:44 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:19774 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262296AbUCGSdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 13:33:43 -0500
Date: Sun, 7 Mar 2004 19:33:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: External kernel modules, second try
Message-ID: <20040307183345.GA2002@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Arjan van de Ven <arjanv@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
	"kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078664629.9812.1.camel@laptop.fenrus.com> <1078667199.3594.50.camel@nb.suse.de> <1078668091.9106.1.camel@laptop.fenrus.com> <20040307160527.GA2027@mars.ravnborg.org> <20040307160824.GA14967@devserv.devel.redhat.com> <1078677922.3615.47.camel@e136.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078677922.3615.47.camel@e136.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 05:45:22PM +0100, Andreas Gruenbacher wrote:
> All in all, in the end I changed my mind. I now think that it's better
> to build modules against a clean kernel source tree that additionally
> has the modversions file copied in. This already works when using O=.
> With the SUBDIRS= approach, the kernel source tree must include a few
> compiled files (scripts/ stuff), and it cannot be read-only.
> 
> I'm still undecided whether it makes sense to disallow the SUBDIRS=
> approach completely and only allow building with O=. (Note that this
> doesn't change the modversion dump file argument.) When building with
> SUBDIRS=, you ideally want a (read-only) kernel source tree that can
> adapt to different configurations (e.g., by doing like this:
> 
>    make -C $KERNEL_SOURCE modules SUBDIRS=$PWD FLAVOR=bigsmp

This is already possible.
You can do:
make -C $KERNEL_SRC SUBDIRS=$PWD O=output-dir modules

or with my proposed syntax:
make -C $KERNEL_SRC M=$PWD O=output-dir

The files relevant for the module will be located in the $PWD dir, since
they use absolute paths.

> 
> ), the default being the running kernel.

I do not want to have potentially distro specific solutions.
So it depends if we can find a solution that most will agree on.

	Sam
