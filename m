Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUKCASP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUKCASP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbUKCASO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:18:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:453 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261285AbUKCARn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:17:43 -0500
Date: Wed, 3 Nov 2004 11:17:26 +1100
From: Nathan Scott <nathans@sgi.com>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Filesystem performance on 2.4.28-pre3 on hardware RAID5.
Message-ID: <20041103111726.B5524750@wobbly.melbourne.sgi.com>
References: <20041029111049.GA554@ribosome.natur.cuni.cz> <20041101102426.G5462300@wobbly.melbourne.sgi.com> <418574FB.2020907@ribosome.natur.cuni.cz> <20041031223214.GB690@frodo> <41878432.5060904@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41878432.5060904@ribosome.natur.cuni.cz>; from mmokrejs@ribosome.natur.cuni.cz on Tue, Nov 02, 2004 at 01:57:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 01:57:22PM +0100, Martin MOKREJ? wrote:
> I retested with blocksize 1024, instead of 512 (default) which causes problems:

4K is the default blocksize, not 1024 or 512 bytes.  From going
through all your notes, the default mkfs parameters are working
fine, and changing to a 512 byte blocksize (-blog=9 / -bsize=512)
is where the VM starts to see problems.

I don't have a device the size of yours handy on my test box, nor
do I have as much memory as you -- but I ran similar bonnie++
commands with -bsize=512 filesystems on a machine with very little
memory, and a filesystem and file size exponentially larger than
available memory, and it ran to completion without problems.
I did see vastly more buffer_heads being created than with the
default mkfs parameters (as we'd expect with that blocksize) but
it didn't cause me any VM problems.

> How can I free the buffer_head without rebooting? I'm trying to help myself with

AFAICT, there is no way to do this without a reboot.  They are
meant to be reclaimed (and were reclaimed on my test box) as
needed, but they don't seem to be for you.

This looks alot like a VM balancing sort of problem to me (that
6G of memory you have is a bit unusual - probably not a widely
tested configuration on i386... maybe try booting with mem=1G
and see if that changes anything?), so far it doesn't seem like
XFS is at fault here at least.

cheers.

-- 
Nathan
