Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbRACBgz>; Tue, 2 Jan 2001 20:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRACBgq>; Tue, 2 Jan 2001 20:36:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59652 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131732AbRACBgc>; Tue, 2 Jan 2001 20:36:32 -0500
Date: Tue, 2 Jan 2001 21:13:52 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: block_truncate_page() change in 2.4.0-prerelease
Message-ID: <Pine.LNX.4.21.0101022102260.15419-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

In 2.4.0-prerelease, you've changed block_truncate_page() to call
__mark_buffer_dirty instead of mark_buffer_dirty before unlocking the
page, so there is no more possibility of it blocking in bdflush while
holding the page locked, which is good.

But now we don't do balancing anymore there. 

The patch I sent you to change mark_buffer_dirty() return the old value of
the dirty bit to know if we need to balance could fix that and with it we  
can the ext2 superblock locking issue, which is horribly bad IMHO. 

Do you want such a change now in 2.4.0-prerelease ?

If so, I can send a patch with all the mark_buffer_dirty and ext2 changes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
