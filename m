Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266792AbUFYQkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbUFYQkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266795AbUFYQkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:40:22 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:32528 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266792AbUFYQkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:40:16 -0400
Date: Fri, 25 Jun 2004 18:40:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Message-ID: <20040625164010.GA5420@pclin040.win.tue.nl>
References: <F12B6443B4A38748AFA644D1F8EF3532151078@bos-ex-01.adprod.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F12B6443B4A38748AFA644D1F8EF3532151078@bos-ex-01.adprod.bmc.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 10:41:13AM -0500, Makhlis, Lev wrote:

> I see that shm_tot (the total number of pages in shm segments) in
> ipc/shm.c is defined as int, even though its max value (shmall) is size_t.
> 
> Admittedly, it only matters for systems with >8TB memory, but shouldn't
> shm_tot also be size_t?  The attached patch makes it so.

> -static int shm_tot; /* total number of shared memory pages */
> +static size_t shm_tot; /* total number of shared memory pages */

First, please avoid attachments.

Secondly, this makes shm_tot unsigned. Have you checked all places
where it occurs in an inequality to see whether the semantics did
change? (It looks OK.)

Thirdly, shm_tot is transmitted to userspace (via the SHM_INFO ioctl)
as an unsigned long. If it is necessary to make it larger, then we
must do something with this ioctl. For example, return -1 there
in case the actual value does not fit in an unsigned long.


