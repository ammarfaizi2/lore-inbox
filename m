Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVI2B4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVI2B4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVI2B4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:56:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33751 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751218AbVI2B4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:56:32 -0400
Date: Thu, 29 Sep 2005 02:56:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050929015629.GP7992@ftp.linux.org.uk>
References: <20050927.152325.424252181.takata.hirokazu@renesas.com> <Pine.LNX.4.58.0509270758040.3308@g5.osdl.org> <20050928001840.GW7992@ftp.linux.org.uk> <20050928.190414.189705294.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928.190414.189705294.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 07:04:14PM +0900, Hirokazu Takata wrote:
> In the top Makefile, CHECKFLAGS is defined as follows:
> CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ $(CF)
> 
> Can I use CF for user specific CHECKFLAGS ?
> What do you think about we specify it manyally for a biendian target?
> 
> ex. m32r
>   sparse check for biendian target
>   $ make ARCH=m32r CF=-D__BIG_ENDIAN__=1 C=1   ... for big-endian
>   $ make ARCH=m32r CF=-D__LITTLE__=1 C=1       ... for little-endian

That's doable, but...  I'd rather not make it mandatory - CF is for
"specific for this build" flags and when used for parallel cross-builds
such requirements make it rather nasty to deal with.
 
> I understand what you said.
> I think having -D__BIG_ENDIAN__ is one of the realistic solutions,
> because it seems that there is no good solution about this problem
> as other people said in this ML-thread.

Note that it's not just sparse.  There is a legitimate need to make
endianness of target visible to Kconfig - not to mention anything
else, there are drivers that are really broken on big-endian targets.
