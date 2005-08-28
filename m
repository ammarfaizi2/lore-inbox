Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVH1Qnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVH1Qnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 12:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVH1Qnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 12:43:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:45563 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751224AbVH1Qne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 12:43:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 1/7] spufs: The SPU file system
Date: Sun, 28 Aug 2005 18:44:17 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <200508260003.40865.arnd@arndb.de> <84144f02050826011778e1142@mail.gmail.com>
In-Reply-To: <84144f02050826011778e1142@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508281844.18187.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 26 August 2005 10:17, Pekka Enberg wrote:
> I am confused. The code is architecture specific and does device I/O. Why do
> you want to put this in fs/ and not drivers/?

I never really thought of it as a device driver but rather an architecture
extension, so it started out in arch/ppc64/kernel. Since most of the code
is interacting with VFS, it is now in fs/spufs. I don't really care about
the location, but I among the possible places to put the code (with the
unified arch/powerpc tree), I'd suggest (best first)

1) arch/powerpc/platforms/cell
2) arch/powerpc/spe
3) fs/spufs
4) drivers/spe

1) would be the place where I want to have the low-level code
(currently arch/ppc64/kernel/spu_base.c) anyway, so it makes
sense to have everything in there that I maintain.
2) might work better if we at a later point have multiple platform
types in arch/powerpc that use SPEs, e.g if we want to keep 
Playstation code separate from generic Cell.

	Arnd <><
