Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUKMUvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUKMUvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 15:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUKMUvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 15:51:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:47783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261167AbUKMUvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 15:51:45 -0500
Date: Sat, 13 Nov 2004 12:51:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041112225850.GA6550@kroah.com>
Message-ID: <Pine.LNX.4.58.0411131249340.12386@ppc970.osdl.org>
References: <20041112225850.GA6550@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Nov 2004, Greg KH wrote:
> 
> David Brownell:
>   o driver core: shrink struct device a bit
> 
> Greg Kroah-Hartman:
>   o driver core: fix up some missed power_state changes from David's patch

Hmm. Apparently drivers/ide/ppc/pmac.c wasn't among those fixed up:

	drivers/ide/ppc/pmac.c: In function `pmac_ide_macio_suspend':
	drivers/ide/ppc/pmac.c:1363: error: structure has no member named `power_state'
	drivers/ide/ppc/pmac.c:1366: error: structure has no member named `power_state'
	...

Is it always valid to just replace

	dev->dev.power_state

with

	dev->dev.power.power_state

or is there anything subtler going on?

		Linus
