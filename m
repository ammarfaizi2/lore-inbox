Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTEMW3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEMW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:29:13 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:60172 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261821AbTEMW3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:29:12 -0400
Date: Tue, 13 May 2003 23:41:34 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5.69: Missing logo?
In-Reply-To: <20030506180707.B15174@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305132334140.12672-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I seem to have a penguin missing in action, somewhere between 2.5.68 and
> 2.5.69.  Has anyone else lost a penguin under similar circumstances?
> 
> $ grep LOGO linux-sa1100/.config
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> 
> Other than the missing logo, the fb display looks as it did under 2.5.68.
> 
> assabet$ fbset
> 
> mode "320x240-60"
>         geometry 320 240 320 240 16
>         timings 171521 61 9 3 0 5 1
>         accel false
>         rgba 5/11,6/5,5/0,0/0
> endmode

At the very bottom of cfbimgblt.c change 

} else if (image->depth == bpp)

to 

} else if (image->depth <= bpp)

and tell me if this works.

P.S
  Is it possible we could move the irq code for the acorn driver from 
fbcon.c to the acorn driver itself. 

