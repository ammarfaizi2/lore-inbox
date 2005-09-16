Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVIPNfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVIPNfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVIPNfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:35:24 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:32598 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S965015AbVIPNfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:35:24 -0400
Date: Fri, 16 Sep 2005 15:35:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: empty kbuild rebuilding all 2.6.13-mm3 ia64 sn2
Message-ID: <20050916133548.GA7663@mars.ravnborg.org>
References: <20050916015412.002642a4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916015412.002642a4.pj@sgi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 01:54:12AM -0700, Paul Jackson wrote:
> Using 2.6.13-mm3, building for SN2 (an ia64 arch) using sn2_defconfig,
> after doing a full successful build, if I just issue another 'make',
> it builds more or less every file all over again.  When I am just
> working in one *.c file, this causes make to be much more expensive
> than it should, rebuilding everything, instead of just that one file
> and relinking (or close to that).

You are hit by the circular dependency in asm-offsets.h.
Tony Luck posted a fix for this to the ia64 list yesterday.

The problem in short is that asm-offsets.c includes asm-offsets.h which it
is also used to generate. So unless they get same timestamp the
kernel will recompile.

	Sam
