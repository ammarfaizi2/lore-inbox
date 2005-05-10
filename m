Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVEJGvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVEJGvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 02:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEJGvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 02:51:08 -0400
Received: from ozlabs.org ([203.10.76.45]:20458 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261564AbVEJGvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 02:51:04 -0400
Date: Tue, 10 May 2005 16:47:17 +1000
From: Anton Blanchard <anton@samba.org>
To: Yoav Zach <yoav_zach@yahoo.com>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       Yoav Zach <yoav.zach@intel.com>
Subject: Re: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64 - 2.6.12-rc3
Message-ID: <20050510064717.GA17819@krispykreme>
References: <20050509214710.419.qmail@web50610.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509214710.419.qmail@web50610.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> In ia64 kernel, the O_LARGEFILE flag is forced when
> opening a file. This is problematic for execution of
> 32 bit processes, which are not largefile aware, either
> by SW emulation or by HW execution.
> For such processes, the problem is two-fold:
> 1) When trying to open a file that is larger than 4G
>    the operation should fail, but it's not
> 2) Writing to offset larger than 4G should fail, but
>    it's not
> 
> The proposed patch takes advantage of the way 32 bit
> processes are identified in ia64 systems. Such 
> processes have PER_LINUX32 for their personality. With
> the patch, the ia64 kernel will not enforce the O_LARGEFILE
> flag if the current process has PER_LINUX32 set.
> The behavior for all other architectures remains unchanged.

A 32 bit application should not be using the native open routine. 

Sounds like you have a 64bit emulator running 32bit applications. The
other 64bit architectures need to be audited to make sure the
PER_LINUX32 flag is safe to use here.

Anton
