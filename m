Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbREWJJ5>; Wed, 23 May 2001 05:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263019AbREWJJr>; Wed, 23 May 2001 05:09:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263018AbREWJJk>; Wed, 23 May 2001 05:09:40 -0400
Subject: Re: [PATCH] struct char_device
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 23 May 2001 10:05:18 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), viro@math.psu.edu (Alexander Viro),
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105221936030.4713-100000@penguin.transmeta.com> from "Linus Torvalds" at May 22, 2001 07:37:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152UZy-00038q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because we still need the partitioning code for backwards
> compatibility. There's no way I'm going to use initrd to do partition
> setup with lvmtools etc.

The current partitioning code consists of re-reading from disk. That is 
code that has to be present anyway even without an initrd since it is needed
for mounting other filesystems

> Also, lvm and friends are _heavyweight_. The partitioning stuff should be
> _one_ add (and perhaps a range check) at bh submit time. None of this
> remapping crap. We don't need no steenking overhead for something we need
> to do anyway.

Thats the kind of LVM layer I am thinking in terms of, not a large block
of LVM code. And for that matter the partition scanner and modifying code
can even be seperate dynamic loaded modules.

At the moment ponder what happens if you have I/Os in flight to /dev/hda3
when you delete /dev/hda2

Alan



