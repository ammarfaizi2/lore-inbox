Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVKWCR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVKWCR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVKWCR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:17:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32902
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932436AbVKWCR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:17:26 -0500
Date: Tue, 22 Nov 2005 18:16:06 -0800 (PST)
Message-Id: <20051122.181606.114580303.davem@davemloft.net>
To: ak@muc.de
Cc: akpm@osdl.org, torvalds@osdl.org, jeffrey.hundstad@mnsu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051123013244.GA3585@muc.de>
References: <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
	<20051122170507.37ebbc0c.akpm@osdl.org>
	<20051123013244.GA3585@muc.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>
Date: 23 Nov 2005 02:32:44 +0100,Wed, 23 Nov 2005 02:32:44 +0100

> On Tue, Nov 22, 2005 at 05:05:07PM -0800, Andrew Morton wrote:
> > davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl.c. 
> > That required inclusion of ext3 and jbd header files.  Those files explode
> > unpleasantly when CONFIG_JBD=n.
> 
> Or use ->compat_ioctl and do it in fs/ext3

And reiserfs and ...  that's why I didn't do it using ->compat_ioctl(),
several other filesystems make use of some of the ext{2,3} ioctls.

I think the ifdef's are a possible solution for now.  But it's very
silly, as we just want some of the ioctl and type definitions.
Perhaps ext3_fs.h can be arranged to still export the ioctl types even
when CONFIG_JBD is disabled?
