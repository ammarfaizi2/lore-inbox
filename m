Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317875AbSFSMv4>; Wed, 19 Jun 2002 08:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSFSMvz>; Wed, 19 Jun 2002 08:51:55 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:18843 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317875AbSFSMvy>;
	Wed, 19 Jun 2002 08:51:54 -0400
Date: Wed, 19 Jun 2002 14:51:54 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions broken in 2.5.23
Message-ID: <20020619125154.GA15739@win.tue.nl>
References: <20020619090248.GA8681@suse.de> <20020619113233.GA15730@win.tue.nl> <20020619134402.B29373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619134402.B29373@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 01:44:02PM +0200, Dave Jones wrote:

> hda2 is odd looking too showing a #blocks of '1', when
> it's actually..
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda2           234     58168  29199240    5  Extended 

That is correct, and something I did before you were born.

An extended partition is a box containing logical partitions.
It is almost always an error when people want to write directly to it
(confusing the extended partition with some logical partition inside).
After a number of reports of people who messed up their disk
by doing mkswap or mkfs on an extended partition I changed
the length of an extended partition to 1 block, enough for LILO
but stopping mkswap and mkfs.
People who really want to access these blocks, like e.g. fdisk,
can do so via /dev/hda.

Andries

