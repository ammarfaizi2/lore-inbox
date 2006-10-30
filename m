Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965352AbWJ3Twv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965352AbWJ3Twv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965371AbWJ3Twv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:52:51 -0500
Received: from brick.kernel.dk ([62.242.22.158]:2638 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965352AbWJ3Twu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:52:50 -0500
Date: Mon, 30 Oct 2006 20:54:27 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Daniel Drake <ddrake@brontes3d.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice blocks indefinitely when len > 64k?
Message-ID: <20061030195426.GO14055@kernel.dk>
References: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Daniel Drake wrote:
> Hi,
> 
> I'm experimenting with splice and have run into some unusual behaviour.
> 
> I am using the utilities in git://brick.kernel.dk/data/git/splice.git
> 
> In splice.h, when changing SPLICE_SIZE from:
> 
> #define SPLICE_SIZE (64*1024)
> 
> to
> 
> #define SPLICE_SIZE ((64*1024)+1)
> 
> splice-cp hangs indefinitely when copying files sized 65537 bytes or
> more. It hangs on the first splice() call.
> 
> Is this a bug? I'd like to be able to copy much more than 64kb on a
> single splice call.

You can't, internally splice is using a pipe which is currently confined
to 16 pages. The SPLICE_SIZE define isn't a suggestion in the code, it
reflects that. You could fix splice-cp to not stall on changing that,
however that still doesn't change the fact that you can only move chunks
of 64kb (on your arch) right now.

-- 
Jens Axboe

