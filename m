Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUEQEas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUEQEas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 00:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUEQEas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 00:30:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7436 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264890AbUEQEaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 00:30:11 -0400
Date: Mon, 17 May 2004 06:29:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Tomasz Chmielewski <mangoo@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: root fs on usb - is patching kernel still needed?
Message-ID: <20040517042903.GB578@alpha.home.local>
References: <40A7BDBC.9010209@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A7BDBC.9010209@interia.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 16, 2004 at 09:15:08PM +0200, Tomasz Chmielewski wrote:
> Are there any solutions for this problem in stable or pre- kernel tree 
> yet (2.4 or 2.6)? If not, will such a solution be ever included in a 
> stable kernel?

AFAICT, none has been merged (yet).

> Or maybe are there any easier solutions for this (some lilo or grub 
> option?)

An initrd might do the trick, although it's sometimes unconvenient to use :
- lilo (or grub) loads the initrd into memory
- lilo (or grub) loads the kernel and executes it
- the kernel sees the initrd and mounts it and executes /linuxrc
- linuxrc can load USB modules and wait the required amount of time
- linuxrc then mounts the root fs and does the pivot_root() and exits
- the kernel finally boots /sbin/init from your USB FS.

Regards,
Willy

