Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267215AbUFZWr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267215AbUFZWr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUFZWr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:47:26 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:6158 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267215AbUFZWqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:46:54 -0400
Date: Sun, 27 Jun 2004 00:46:52 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: andyb@island.net
Cc: linux-kernel@vger.kernel.org, aebr@win.tue.nl
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
Message-ID: <20040626224652.GD5526@pclin040.win.tue.nl>
References: <1088216934.40dcdf66edd1d@webmail.island.net> <20040626104455.GC5526@pclin040.win.tue.nl> <1088267564.40dda52cc629a@webmail.island.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088267564.40dda52cc629a@webmail.island.net>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 09:32:44AM -0700, andyb@island.net wrote:

> displays the partition table for the drive that the kernel claims has an unknown
> partition table.  The bootable flag indicator is neither blank nor an *;  instead it
> was the ? character.  Toggling the bootable flag in fdisk (bringing up the * ) and
> writing the changed partition table allowed the booting kernel to then read
> the partition table.   This partition table has not been touched for many a kernel
> version and has been identified by all the previous kernels, through 2.6.6.
> Would the change that stopped the kernel from "guessing" the disk geometry have
> brought out the sensitivity to whatever was not correct with the PT?

Ah, excellent. See - I have no memory.

No - I keep repeating: please stop this geometry nonsense.

This is something entirely different. Linux does automatic partition recognition.
That of course is bad, especially if there is no partition table at all, like on
certain ZIP drives and memory cards for digital cameras (that behave like
big floppies). In order to guess right more often the kernel now only believes
that something is a valid DOS-type partition table when there is a valid
bootable flag indicator (0 or 0x080).
You had garbage there (or at least an unusual value) - and the garbage was harmless,
but now causes the kernel to reject this table.

Remains the question: do you have any idea from where you got this unusual value?

Andries
