Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUIVW1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUIVW1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUIVW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:27:30 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:22671 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268048AbUIVW1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:27:24 -0400
Date: Thu, 23 Sep 2004 00:27:23 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com
Subject: Re: 2.6.8 link failure for powerpc-970?
Message-ID: <20040922222723.GD30109@MAIL.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	arjanv@redhat.com
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com> <4150EF69.1060007@kegel.com> <4151AB3D.3040003@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4151AB3D.3040003@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 09:41:33AM -0700, Dan Kegel wrote:
> Dan Kegel wrote:
> >>On Mon, 2004-09-20 at 10:24, Dan Kegel wrote:
> >>
> >>>I'm trying to verify that I can build toolchains and compile
> >>>and link kernels for a large set of CPU types using simple kernel 
> >>>config files.

Hi Dan!

once you figured out what 'default' configs
are appropriate for the special archs not working
with allyes/noconfig could you send me a note
and/or post a link to them somewhere?

TIA,
Herbert

> >>>I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
> >>>So any problems I run into are a bit hard to pin down to
> >>>compiler, kernel, or user error, since this is mostly new territory 
> >>>for me.  ...
> >
> >arch/ppc64/kernel/built-in.o(.text+0xdc44): In function `.sys32_ipc':
> >: undefined reference to `.compat_sys_shmctl'
> > ...
> 
> Could it be a config problem?  My config file was from 'allnoconfig', I 
> think, and has
> $ egrep 'SYSV|COMPAT' .config
> CONFIG_COMPAT=y
> # CONFIG_SYSVIPC is not set
> compat_sys_shmctl is in ipc/compat.c, and is enabled by 
> CONFIG_SYSVIPC_COMPAT,
> which depends on CONFIG_SYSVIPC, which is off.
> 
> The reference to compat_sys_shmctl seems to be in
> ./arch/ia64/ia32/sys_ia32.c
> ./arch/ppc64/kernel/sys_ppc32.c
> ./arch/x86_64/ia32/ipc32.c
> ./arch/s390/kernel/compat_linux.c
> and appears to not be conditioned on CONFIG_SYSVIPC_COMPAT.
> Seems like linking problems are expected unless you turn on
> CONFIG_SYSVIPC and CONFIG_SYSVIPC_COMPAT.
> 
> I turned 'em on and am trying again.
> - Dan
> 
> -- 
> My technical stuff: http://kegel.com
> My politics: see http://www.misleader.org for examples of why I'm for 
> regime change
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
