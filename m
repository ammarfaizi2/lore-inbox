Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbULFAyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbULFAyG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbULFAvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:51:52 -0500
Received: from palrel10.hp.com ([156.153.255.245]:17874 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261444AbULFAre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:47:34 -0500
Date: Mon, 6 Dec 2004 11:47:22 +1100
From: Martin Pool <mbp@sourcefrog.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: rescan partitions returns EIO since 2.6.8
Message-ID: <20041206004722.GD26060@hp.com>
Mail-Followup-To: Martin Pool <mbp@sourcefrog.net>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <200412051403.iB5E3EJ01749@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412051403.iB5E3EJ01749@apps.cwi.nl>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Dec 2004, Andries.Brouwer@cwi.nl wrote:
> Martin Pool changed the behaviour of the BLKRRPART ioctl in 2.6.8.
> The effect is that one now gets an I/O error when first
> partitioning an empty disk:

> # sfdisk /dev/sda
> Checking that no-one is using this disk right now ...
> BLKRRPART: Input/output error

To me it seems more correct that a request to read the partition table
should fail if the partition table can't be read.  I had some code
that did care to know the difference, but if you really want to roll
it back I won't object.

fdisk, cfdisk and parted all just give a warning in this case.  You
can tell sfdisk to ignore the error with --no-reread.

-- 
Martin 
