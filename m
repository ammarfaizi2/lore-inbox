Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUIASbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUIASbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUIASbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:31:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266611AbUIASbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:31:32 -0400
Date: Wed, 1 Sep 2004 19:31:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Roland Dreier <roland@topspin.com>
Cc: Chris Wright <chrisw@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901183132.GS16297@parcelfarce.linux.theplanet.co.uk>
References: <20040901072245.GF13749@mellanox.co.il> <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk> <52zn4a0ysg.fsf@topspin.com> <20040901110225.D1973@build.pdx.osdl.net> <52656x26zl.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52656x26zl.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 11:12:46AM -0700, Roland Dreier wrote:
>     Chris> You forgot a driver specific filesystem which exposes
>     Chris> requests in a file per request type style.  Also, there's a
>     Chris> simple_transaction type of file which can allow you
>     Chris> send/recv data and should eliminate the need for tagging.
>     Chris> Example, look at nfsd fs (fs/nfsd/nfsctl.c).
> 
> Thanks, I'll take a look at this.  How does one handle the 32-bit
> userspace / 64-bit kernel compat layer in this setup?

The sane approach is to have your structure platform-independent and have
no compat code at all.  Which is what we do with on-disk and over-the-wire
structures anyway.  And before Albert starts usual wanksession, no, ASCII
is not the only way to do that...
