Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130227AbRBUW1S>; Wed, 21 Feb 2001 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130254AbRBUW1I>; Wed, 21 Feb 2001 17:27:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22796 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130225AbRBUW0u>; Wed, 21 Feb 2001 17:26:50 -0500
Date: Wed, 21 Feb 2001 23:26:35 +0100
From: Martin Mares <mj@suse.cz>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Daniel Phillips <phillips@innominate.de>, ext2-devel@lists.sourceforge.net,
        hch@ns.caldera.de, Andreas Dilger <adilger@turbolinux.com>,
        tytso@valinux.com, Linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010221232635.A25272@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <XFMail.20010221135903.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <XFMail.20010221135903.davidel@xmailserver.org>; from davidel@xmailserver.org on Wed, Feb 21, 2001 at 01:59:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> My personal preference goes to skiplist coz it doesn't have fixed ( or growing
> ) tables to handle. You've simply a stub of data togheter with FS data in each
> direntry.

Another problem with skip lists is that they require variable sized nodes,
so you either need to keep free chunk lists and lose some space in deleted
nodes kept in these lists, or you choose to shift remaining nodes which is
slow and complicated as you need to keep the inter-node links right. With
hashing, you can separate the control part of the structure and the actual
data and shift data while leaving most of the control part intact.

> And performance ( O(log2(n)) ) are the same for whatever number of entries.

I don't understand this complexity estimate -- it cannot be the same for
whatever number of entries as the complexity function depends on the number
of entries.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
P.C.M.C.I.A. stands for `People Can't Memorize Computer Industry Acronyms'
