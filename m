Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265875AbUFDROa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUFDROa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUFDROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:14:30 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:33737 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265877AbUFDRO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:14:26 -0400
Message-ID: <40C0AE16.F4F222DD@users.sourceforge.net>
Date: Fri, 04 Jun 2004 20:15:02 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: =?iso-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlinks for building external modules
References: <200406031858.09178.agruen@suse.de> <yw1x8yf44lgp.fsf@kth.se> <20040603173656.GA2301@mars.ravnborg.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Jun 03, 2004 at 07:09:42PM +0200, Måns Rullgård wrote:
> > Andreas Gruenbacher <agruen@suse.de> writes:
> > > modules not in the kernel source tree need to locate both the source
> > > tree and the object tree (O=). Currently, the /lib/modules/$(uname
> > > -r)/build symlink is the only reference we have; it historically
> > > points to the source tree from 2.4 times. The following patch
> > > changes this as follows (this is what we have in the current SUSE
> > > tree now):
> > >
> > >     /lib/modules/$(uname -r)/source ==> source tree
> > >     /lib/modules/$(uname -r)/build ==> object tree
> >
> > This will break the building of all external modules until they are
> > updated, and break updated modules building against older kernels
> > unless they check the kernel version in the makefiles..  I suggest
> > leaving the 'build' link as is, and using a difference name for the
> > build directory, perhaps 'object'.  This might look confusing, so we
> > could have a 'source' link as well and remove the 'build' link when
> > most external modules have been updated.
> 
> The existing external modules are anyway broken when using separate
> directories for source and output directories. So noting lost here.

Wrong! Existing external modules build fine when specified an object
directory.

> In the case where the kernel is build in the traditional way
> the build and source tree will point to the same place.
> 
> So I do not see this patch breaking existing setups, but I see
> external modules not being prepared for separate build and source
> directories.

How long have you recommended building external modules like this:

 make -C /lib/modules/`uname -r`/build modules SUBDIRS=`pwd`
  or
 make -C /lib/modules/`uname -r`/build modules M=`pwd`

Now they all have to be changed to:

 make -C /lib/modules/`uname -r`/source modules SUBDIRS=`pwd`
  or
 make -C /lib/modules/`uname -r`/source modules M=`pwd`

And the worst part is that modules that have to support old and new
kernel versions have to first detect which method to use, and
select method that applies to that paricular kernel version.

> Patch looks good to me, and I will forward to Andrew soon.

That patch only breaks stuff. Please use the 'object' symlink
suggested by Måns Rullgård. That does not break anything.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
