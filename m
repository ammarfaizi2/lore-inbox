Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262954AbREWCib>; Tue, 22 May 2001 22:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262955AbREWCiV>; Tue, 22 May 2001 22:38:21 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23046 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262954AbREWCiJ>; Tue, 22 May 2001 22:38:09 -0400
Date: Tue, 22 May 2001 19:37:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alexander Viro <viro@math.psu.edu>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <3B0AFEFE.1198871C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0105221936030.4713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001, Jeff Garzik wrote:
> 
> Alan recently straightened me out with "EVMS/LVM is partitions done
> right"
> 
> so... why not implement partitions as simply doing block remaps to the
> lower level device?  That's what EVMS/LVM/md are doing already.

Because we still need the partitioning code for backwards
compatibility. There's no way I'm going to use initrd to do partition
setup with lvmtools etc.

Also, lvm and friends are _heavyweight_. The partitioning stuff should be
_one_ add (and perhaps a range check) at bh submit time. None of this
remapping crap. We don't need no steenking overhead for something we need
to do anyway.

		Linus

