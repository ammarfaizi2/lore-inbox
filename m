Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWA1EqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWA1EqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWA1EqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:46:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49829
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751584AbWA1EqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:46:15 -0500
Date: Fri, 27 Jan 2006 20:46:45 -0800 (PST)
Message-Id: <20060127.204645.96477793.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@hansmi.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] framebuffer: Remove old radeon driver
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1138421392.30599.10.camel@localhost.localdomain>
References: <20060127231314.GA28324@hansmi.ch>
	<1138421392.30599.10.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 28 Jan 2006 15:09:52 +1100

> On Sat, 2006-01-28 at 00:13 +0100, Michael Hanselmann wrote:
> > This patch removes the old radeon driver which has been replaced by a
> > newer one.
> > 
> > Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I have no problem with this, but I want to point out one
artifact of the current Radeon driver which drivers me nuts
:-)

The radeon_screen_blank() routine returns error codes back
to the X server which handily confuses it, making it
impossible to unblank the screen unless X has taken it
all the way to power-off or somesuch.  The comment above
this problematic code states:

	/* let fbcon do a soft blank for us */
	return (blank == FB_BLANK_NORMAL) ? -EINVAL : 0;

There has to be a better way to do this, which doesn't break
X when run via fbcon. :-)

