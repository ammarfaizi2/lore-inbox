Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273109AbRIIX5G>; Sun, 9 Sep 2001 19:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRIIX45>; Sun, 9 Sep 2001 19:56:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:47880 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273107AbRIIX4n>; Sun, 9 Sep 2001 19:56:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com (Linus Torvalds)
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 02:04:19 +0200
X-Mailer: KMail [version 1.3.1]
Cc: adilger@turbolabs.com (Andreas Dilger), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <E15gEPC-00084T-00@the-village.bc.nu>
In-Reply-To: <E15gEPC-00084T-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010909235703Z16150-26183+678@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 01:54 am, Alan Cox wrote:
> How do you plan to handle the situation where we have multiple instances
> of the same 4K disk block each of which contains 1K of data in the
> start of the page copy and 3K of zeroes.
> 
> This isnt idle speculation - thing about BSD UFS fragments.

This is handled the same way ReiserFS handles tail merging now - by 
instantiating multiple pages in the respective inode mappings with copies
of the respective parts of the shared block, which stays in the physical
block cashe (aka buffer cache).

The dirty work is done by xxx_get_block.

--
Daniel
