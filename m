Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbWF0Rug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWF0Rug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWF0Rug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:50:36 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:49553 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932495AbWF0Ruf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:50:35 -0400
Date: Tue, 27 Jun 2006 19:50:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KBUILD tries to make initramfs contents :-)
Message-ID: <20060627175032.GB26435@mars.ravnborg.org>
References: <m3wtb27noz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wtb27noz.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 03:06:20PM +0200, Krzysztof Halasa wrote:
> Hi,
> 
> I'm a bit surprised :-)
> 
> I'm using a file list for initramfs generation. It's something like:
> 
> file /sbin/udev /usr/local/i386/build/udev/udev 0555 0 0
> file /sbin/udevd /usr/local/i386/build/udev/udevd 0555 0 0
> ...
> 
> /usr/local/i386/build/udev directory contains full udev sources, not
> just the executables.
> 
> Now "make linux" wants to rebuild udev executables, using kernel
> build rules :-)
> 
> All details are of course available on request if needed.
> 
> This is 2.6.17, I haven't checked it but I think the change to
> usr/Makefile which causes this is:
> 
> commit d39a206bc35d46a3b2eb98cd4f34e340d5e56a50
> Author: Sam Ravnborg <sam@mars.ravnborg.org>
> Date:   Tue Apr 11 13:24:32 2006 +0200
> 
>     kbuild: rebuild initramfs if content of initramfs changes
>     
>     initramfs.cpio.gz being build in usr/ and included in the
>     kernel was not rebuild when the included files changed.
>     
>     To fix this the following was done:
>     - let gen_initramfs.sh generate a list of files and directories included
>       in the initramfs
>     - gen_initramfs generate the gzipped cpio archive so we could simplify
>       the kbuild file (Makefile)
>     - utilising the kbuild infrastructure so when uid/gid root mapping changes
>       the initramfs will be rebuild
>     
>     With this change we have a much more robust initramfs generation.
> 
> 
> Should it stay this way or is it a bug?
Oh Crap. It's a bug. The intent it to rebuild initramfs when content of
the initramfs changes.
But not to rebuild content of initramfs of course.

No solution right now - will take a look during the weekend.

	Sam
