Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRACAFz>; Tue, 2 Jan 2001 19:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbRACAFp>; Tue, 2 Jan 2001 19:05:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2689 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130271AbRACAFg>;
	Tue, 2 Jan 2001 19:05:36 -0500
Date: Tue, 2 Jan 2001 18:33:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: [RFC] ext2_new_block() behaviour
In-Reply-To: <200012010827.eB18R0u22296@webber.adilger.net>
Message-ID: <Pine.GSO.4.21.0101021817140.13824-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, there is a pretty strange detail of the allocation policy -
if cylinder group has no free blocks past the goal ext2 tries very hard to
avoid allocation in the beginning of the group. I.e. order looks so:

	* goal
	* goal .. (goal+63) & ~63
	* goal .. end of cylinder group
	* cylinder groups past one that contains goal
	* cylinder groups before one that contains goal
	* beginning of cylinder group..goal-1

It looks somewhat fishy. What's the reason for such policy?
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
