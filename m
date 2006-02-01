Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWBAJIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWBAJIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBAJHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:07:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:34716 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932407AbWBAJHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:07:16 -0500
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date: Wed, 1 Feb 2006 10:06:07 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>
References: <20060201090224.536581000@localhost.localdomain> <20060201090325.905071000@localhost.localdomain>
In-Reply-To: <20060201090325.905071000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011006.09596.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:

> +static inline unsigned int hweight32(unsigned int w)
> +{
> +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
> +        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
> +        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
> +        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
> +}

How large are these functions on x86? Maybe it would be better to not inline them,
but put it into some C file out of line.

-Andi
