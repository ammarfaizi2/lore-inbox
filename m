Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUJJWvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUJJWvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 18:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUJJWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 18:51:46 -0400
Received: from support.codesourcery.com ([65.74.133.10]:21238 "EHLO
	mail.codesourcery.com") by vger.kernel.org with ESMTP
	id S268534AbUJJWvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 18:51:45 -0400
To: linux-kernel@vger.kernel.org, "J. A. Magallon" <jamagallon@able.es>
Subject: Re: udev: what's up with old /dev ?
In-Reply-To: <1097446129l.5815l.0l@werewolf.able.es>
References: <1097446129l.5815l.0l@werewolf.able.es>
From: Zack Weinberg <zack@codesourcery.com>
Date: Sun, 10 Oct 2004 15:51:43 -0700
Message-ID: <87vfdiw5j4.fsf@codesourcery.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Is it possible to boot with an empty /dev, until udev builds it ?
> - If this is not the case, which are the minimal nodes that should be
> present ?

Having just done this experiment myself: With kernel 2.6.8, udev 034,
Debian unstable's init scripts, and no initramfs or initrd, it
suffices to have /dev/console and /dev/null in the root filesystem's
/dev.

The very first thing init does is open /dev/console, and if it doesn't
exist the entire boot hangs.  Thus, the only way to avoid having that
node on the root filesystem would be to set up udev from initrd or
initramfs.  I'm sure that's possible but I don't know how to do it;
and the boot scripts that exist right now in Debian unstable are not
set up to handle that case.

It may not be necessary to have /dev/null on the root filesystem; I
didn't try that.  Libc and the shell frequently open /dev/null behind
one's back, so I suspect it is wanted before udev starts up.

I have no idea what distros are planning in this area.

zw
