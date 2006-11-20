Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934166AbWKTN5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934166AbWKTN5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 08:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934168AbWKTN5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 08:57:24 -0500
Received: from flvpn.ccur.com ([66.10.65.2]:39095 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S934166AbWKTN5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 08:57:23 -0500
Date: Mon, 20 Nov 2006 08:57:16 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFSROOT with NFS Version 3
Message-ID: <20061120135716.GA14122@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de> <1163780417.5709.34.camel@lade.trondhjem.org> <20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:07:50PM +0100, Christoph Pleger wrote:
> Warning: Unable to open an initial console

This usually means /dev/console doesn't exist.  With many of
today's distributions, this means you didn't boot with a
initrd properly set up to run with your newly built kernel.

If you don't want to create an initrd just to get yourself
a properly set up /dev, then you need to put on the root's
true /dev those few tmpfs /dev entries that might be used
during the boot process:

    mount --bind / /mnt
    cd /mnt/dev
    mknod null c 1 3
    mknod console c 5 1
    for i in $(seq 0 9); do mknod tty$i c 4 $i; done
    cd /
    umount /mnt

Joe
