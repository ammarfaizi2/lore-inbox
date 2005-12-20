Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVLTRUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVLTRUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVLTRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:20:42 -0500
Received: from mail.autoweb.net ([198.172.237.26]:41401 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750707AbVLTRUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:20:41 -0500
Date: Tue, 20 Dec 2005 12:20:26 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051220172026.GC2437@mythryan2.michonline.com>
References: <43A5F058.1060102@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A5F058.1060102@tlinx.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 03:27:20PM -0800, Linda Walsh wrote:
> Unpacked 2.6.13.3 and made it read-only.
> 
> Using the "O=" param, built output tree for another machine as
> a non-root user.
> 
> I wanted to create an installable kernel & module package to copy
> to the new machine & install.
> 
> I noted new targets:
>    binrpm-pkg [& rpm-pkg], and
>    tarbz2-pkg [& targz-pkg, & tar-pkg].
> 
> Both seem to fail either for reasons that appear to be related to
> not honoring the "O=" param, or attempting to actually install into
> the root of my build-machine.
> 
> Should these targets work or have they not yet been converted to work
> within the "O=" framework?  In cases where the Makefile is attempting
> to install into "<Root>/boot" or "<Root>/lib/modules" ,should I
> expect the output to appear in "$O/boot" and "$O/lib/modules/"?

Look at the "deb" target for how this was fixed for building Debian
(-style) packages.

Specifically, you want to change:
	$(MAKE)
to
	$(MAKE) KBUILD_SRC=

At a glance, I don't see a similar problem in the binrpm-pkg target, and
I don't understand the rpm target at all, so those may have other
issues.

I am, however, looking at 2.6.15-rc{something}, not 2.6.13, but I think
it's been a while since Sam sent the deb packages fixes upstream.

-- 

Ryan Anderson
  sometimes Pug Majere
