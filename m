Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTJRTZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJRTZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:25:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261807AbTJRTZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:25:18 -0400
Date: Sat, 18 Oct 2003 20:25:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Svetoslav Slavtchev <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd and 2.6.0-test8
Message-ID: <20031018192517.GD7665@parcelfarce.linux.theplanet.co.uk>
References: <22900.1066504204@www30.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22900.1066504204@www30.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 09:10:04PM +0200, Svetoslav Slavtchev wrote:
> me had  the same problems,
> with devfs enabled
> 
> could it be this (from Documentation/initrd)
> 
> Note that changing the root directory does not involve unmounting it.
>     the "normal" root file system is mounted. initrd data can be read
>   root=/dev/ram0   (without devfs)
>   root=/dev/rd/0   (with devfs)
>     initrd is mounted as root, and the normal boot procedure is followed,
>     with the RAM disk still mounted as root.
> 
> the patch doesn't mention anything about /dev/rd/0 , but does for /dev/ram0

*Arrgh*

Presense of devfs is, indeed, the problem.  /dev/rd/0 vs. /dev/ram0 is not
an issue; visibility of /dev/initrd, OTOH, is - we have /dev of rootfs
overmounted by devfs, so the thing becomes inaccessible.

OK, that's trivially fixable.  We need to put the sucker outside of /dev,
that's all.  Patch in a few...
