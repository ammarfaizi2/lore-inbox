Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUFYUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUFYUj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUFYUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:39:27 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:20491 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266263AbUFYUj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:39:26 -0400
Date: Fri, 25 Jun 2004 22:39:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Message-ID: <20040625203914.GA5504@pclin040.win.tue.nl>
References: <F12B6443B4A38748AFA644D1F8EF3532147332@bos-ex-01.adprod.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F12B6443B4A38748AFA644D1F8EF3532147332@bos-ex-01.adprod.bmc.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 12:42:26PM -0500, Makhlis, Lev wrote:

> > Thirdly, shm_tot is transmitted to userspace (via the SHM_INFO ioctl)
> > as an unsigned long. If it is necessary to make it larger, then we
> > must do something with this ioctl. For example, return -1 there
> > in case the actual value does not fit in an unsigned long.
> 
> The SHM_INFO shmctl is actually how I found it in the first place.
> But we have the same situation with many other values.  For example,
> shm_ctlmax, shm_ctlall and shm_segsz can all potentially be 64-bit wide
> in the kernel and are exported into potentially 32-bit userspace values.
> We don't return -1 for any of those if they don't fit.  Is there a
> special reason to do it in this case?

There is a good reason to do it always.
If one truncates, then the result is always unreliable.
If one replaces a too large value by -1, then any other value is reliable.
