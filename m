Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273360AbRJIHD4>; Tue, 9 Oct 2001 03:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRJIHDk>; Tue, 9 Oct 2001 03:03:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18321 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273358AbRJIHD3>;
	Tue, 9 Oct 2001 03:03:29 -0400
Date: Tue, 9 Oct 2001 03:03:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Nathan Scott <nathans@sgi.com>
cc: Jan Kara <jack@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Quotactl change
In-Reply-To: <20011008203418.A505344@wobbly.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0110090256140.13381-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, Nathan Scott wrote:

> hi all,
> 
> Al - is the attached patch more along the lines of what you
> were after?

Quota side looks sane.  fs/super.c one is an overkill - just set default in
alloc_super().  There is no need to bother with resetting it - in the
places where you do it superblock is already deactivated, so get_super()
in quotactl will not return it and at that point there should be no inodes
left from that filesystem.

