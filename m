Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264834AbUEVCyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264834AbUEVCyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbUEVCyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:54:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48872 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264834AbUEVCyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:54:01 -0400
Date: Sat, 22 May 2004 03:54:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Spinka, Kristofer" <kspinka@style.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unserializing ioctl() system calls
Message-ID: <20040522025400.GU17014@parcelfarce.linux.theplanet.co.uk>
References: <web-1649994@style.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <web-1649994@style.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 10:46:45PM -0400, Spinka, Kristofer wrote:
> I noticed that even in the 2.6.6 code, callers to ioctl 
> system call (sys_ioctl in fs/ioctl.c) are serialized with 
> {lock,unlock}_kernel().
> 
> I realize that many kernel modules, and POSIX for that 
> matter, may not be ready to make this more concurrent.
> 
> I propose adding a flag to indicate that the underlying 
> module would like to support its own concurrency 
> management, and thus we avoid grabbing the BKL around the 
> f_op->ioctl call.
> 
> The default behavior would adhere to existing standards, 
> and if the flag is present (in the underlying module), we 
> let the module (or modules) handle it.
> 
> Reasonable?

No.  Flags on drivers are never a good idea.  What's more, if somebody
wants that shit parallelized they can always drop BKL upon entry and
reacquire on exit from their ->ioctl().
