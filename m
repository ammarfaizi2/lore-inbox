Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWASJXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWASJXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWASJXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:23:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:41482 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750750AbWASJXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:23:30 -0500
Date: Thu, 19 Jan 2006 10:23:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
Message-ID: <20060119092320.GA8588@mars.ravnborg.org>
References: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com> <20060119073509.GA8231@mars.ravnborg.org> <a44ae5cd0601190115y6f6e93a1y6b6b6284280259fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0601190115y6f6e93a1y6b6b6284280259fd@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:15:49AM -0800, Miles Lane wrote:
> I do have .kernelrelease that contains:
> "2.6.16-rc1-mm1 .file null .ident
> GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> .note.GNU-stack,,@progbits"
> I tried deleting it,  but it gets recreated.
> 
> I'm pretty frustrated.  I have built hundreds of kernels and have not
> hit this problem before.
> 
> Any help is most appreciated!
This can also be a side-effect of /dev/null being damaged.
In scripts/kconfig/lxdialog/check-lxdialog.sh we do:
echo main() {} | gcc -nncursesw -cx - -o /dev/null

I could imagine that your /dev/null has become a regular file and is now
filled with garbage.
And then the trick:
cat /dev/null $(wildcard .kernelrelease)
causes KERNELRELEASE to be full of crap.

Care to check that?

I have not a patch ready to fix the /dev/null issue - later today.

	Sam
