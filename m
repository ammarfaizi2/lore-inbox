Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265902AbUFDTph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUFDTph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUFDTph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:45:37 -0400
Received: from mail.broadpark.no ([217.13.4.2]:2018 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265902AbUFDTpe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:45:34 -0400
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlinks for building external modules
References: <200406031858.09178.agruen@suse.de> <yw1x8yf44lgp.fsf@kth.se>
	<20040603173656.GA2301@mars.ravnborg.org>
	<40C0AE16.F4F222DD@users.sourceforge.net>
	<20040604192304.GB3530@mars.ravnborg.org>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Fri, 04 Jun 2004 21:45:33 +0200
In-Reply-To: <20040604192304.GB3530@mars.ravnborg.org> (Sam Ravnborg's
 message of "Fri, 4 Jun 2004 21:23:04 +0200")
Message-ID: <yw1xy8n3yun6.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Fri, Jun 04, 2004 at 08:15:02PM +0300, Jari Ruusu wrote:
>> 
>> How long have you recommended building external modules like this:
>> 
>>  make -C /lib/modules/`uname -r`/build modules SUBDIRS=`pwd`
>>   or
>>  make -C /lib/modules/`uname -r`/build modules M=`pwd`
>> 
>> Now they all have to be changed to:
>> 
>>  make -C /lib/modules/`uname -r`/source modules SUBDIRS=`pwd`
>>   or
>>  make -C /lib/modules/`uname -r`/source modules M=`pwd`
>
> That would not work either.
> You need to tell kbuild both where to find the source and the output files.
> So you have to specify both -C ... and O=...
> KERNEL=/lib/modules/`uname -r`
> make -C $KERNEL/source O=$KERNEL/build M=`pwd`
>
> There is no way to do the proposed chang and be backward compatible
> when the kernel is build using seperate output directories.

There are many external module packages that assume
/lib/modules/`uname -r`/build to contain the kernel sources.  These
can be built with

  make O=/some/path

If the content of /lib/modules/`uname -r`/build changes this will no
longer work.

> Think of the following situation
> /usr/src/linux-2.6.6-xx/  <= kernel src
>
> /lib/modules/linux-2.6.6-xx-smp/build/ <= output files (or a symlink to them)
> /lib/modules/linux-2.6.6-xx-smp/source/ <= symlink to kernel src
>
> /lib/modules/linux-2.6.6-xx-up/build/ <= output files (or symlink)
> /lib/modules/linux-2.6.6-xx-up/source/ <= symlink to kernel src
>
> /lib/modules/linux-2.6.6-xx-4g/build/ <= output files (or symlink)
> /lib/modules/linux-2.6.6-xx-4g/source/ <= symlink to kernel src
>
> Notice they all share the _same_ kernel src.
> We just have three different .config files.
>
> If there is a way to be backward compatible with
> this feature please demonstrate it.
>
> Plese note that the patch Andreas made did not break existing setups
> if a seperate output directory was not used. The only effect
> would be an additional symlink to the same dir. (build and source would
> be links to the same dir).
>
> Andreas - please expalin why you want build to be a symlink, and not
> the directory used when actually building the kernel.

I can't speak for Andreas, but I prefer to keep my root filesystem as
clean as possible.  Often it's mounted read-only.

-- 
Måns Rullgård
mru@kth.se
