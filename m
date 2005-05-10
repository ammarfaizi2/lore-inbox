Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVEJQP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVEJQP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVEJQP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:15:26 -0400
Received: from fmr24.intel.com ([143.183.121.16]:15249 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261655AbVEJQPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:15:23 -0400
Date: Tue, 10 May 2005 09:15:12 -0700
From: tony.luck@intel.com
Message-Id: <200505101615.j4AGFCM24199@unix-os.sc.intel.com>
To: Anton Blanchard <anton@samba.org>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       Yoav Zach <yoav.zach@intel.com>
Subject: Re: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64 - 2.6.12-rc3
In-Reply-To: <20050510064717.GA17819@krispykreme>
References: <20050509214710.419.qmail@web50610.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> A 32 bit application should not be using the native open routine. 
> 
> Sounds like you have a 64bit emulator running 32bit applications. The
> other 64bit architectures need to be audited to make sure the
> PER_LINUX32 flag is safe to use here.

Yes, this issue happens when using an emulator to "run" the 32-bit
application.

Yoav's patch leaves it to each architecture to decide how to
identify the emulated case.  ia64 has been using PER_LINUX32
for this.  If other 64-bit architectures ever need to do the
same thing, they can provide their own force_o_largefile()
macro.  Right now, I don't think that any of them need this
because they aren't using emulators for 32-bit.

-Tony
