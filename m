Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269376AbUICICo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269376AbUICICo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUICICn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:02:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:46796 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269367AbUICIA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:00:58 -0400
Date: Fri, 3 Sep 2004 10:00:58 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040903080058.GB2402@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901072245.GF13749@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> Hello!
> Currently, on the x86_64 architecture, its quite tricky to make
> a char device ioctl work for an x86 executables.
> In particular,
>    1. there is a requirement that ioctl number is unique -
>       which is hard to guarantee especially for out of kernel modules

Yes, that is a problem for some people. But you should
have used an unique number in the first place.

There are some hackish ways to work around it for non modules[1], but at some
point we should probably support it better.

[1] it can be handled, except for module unloading, so you have
to disable that.

>    2. there's a performance huge overhead for each compat call - there's
>       a hash lookup in a global hash inside a lock_kernel -
>       and I think compat performance *is* important.

Did you actually measure it? I doubt it is a big issue.

-Andi
