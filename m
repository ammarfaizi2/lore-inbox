Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUFDTTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUFDTTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUFDTTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:19:13 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:51532 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265938AbUFDTSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:18:40 -0400
Date: Fri, 4 Jun 2004 21:23:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlinks for building external modules
Message-ID: <20040604192304.GB3530@mars.ravnborg.org>
Mail-Followup-To: Jari Ruusu <jariruusu@users.sourceforge.net>,
	Sam Ravnborg <sam@ravnborg.org>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200406031858.09178.agruen@suse.de> <yw1x8yf44lgp.fsf@kth.se> <20040603173656.GA2301@mars.ravnborg.org> <40C0AE16.F4F222DD@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0AE16.F4F222DD@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 08:15:02PM +0300, Jari Ruusu wrote:
> 
> How long have you recommended building external modules like this:
> 
>  make -C /lib/modules/`uname -r`/build modules SUBDIRS=`pwd`
>   or
>  make -C /lib/modules/`uname -r`/build modules M=`pwd`
> 
> Now they all have to be changed to:
> 
>  make -C /lib/modules/`uname -r`/source modules SUBDIRS=`pwd`
>   or
>  make -C /lib/modules/`uname -r`/source modules M=`pwd`

That would not work either.
You need to tell kbuild both where to find the source and the output files.
So you have to specify both -C ... and O=...
KERNEL=/lib/modules/`uname -r`
make -C $KERNEL/source O=$KERNEL/build M=`pwd`

There is no way to do the proposed chang and be backward compatible
when the kernel is build using seperate output directories.

Think of the following situation
/usr/src/linux-2.6.6-xx/  <= kernel src

/lib/modules/linux-2.6.6-xx-smp/build/ <= output files (or a symlink to them)
/lib/modules/linux-2.6.6-xx-smp/source/ <= symlink to kernel src

/lib/modules/linux-2.6.6-xx-up/build/ <= output files (or symlink)
/lib/modules/linux-2.6.6-xx-up/source/ <= symlink to kernel src

/lib/modules/linux-2.6.6-xx-4g/build/ <= output files (or symlink)
/lib/modules/linux-2.6.6-xx-4g/source/ <= symlink to kernel src

Notice they all share the _same_ kernel src.
We just have three different .config files.

If there is a way to be backward compatible with
this feature please demonstrate it.

Plese note that the patch Andreas made did not break existing setups
if a seperate output directory was not used. The only effect
would be an additional symlink to the same dir. (build and source would
be links to the same dir).


Andreas - please expalin why you want build to be a symlink, and not
the directory used when actually building the kernel.
 
	Sam

