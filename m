Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUGEBYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUGEBYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 21:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUGEBYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 21:24:51 -0400
Received: from almesberger.net ([63.105.73.238]:45065 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265887AbUGEBYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 21:24:49 -0400
Date: Sun, 4 Jul 2004 22:24:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: prio_tree generalization
Message-ID: <20040704222438.A11865@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

I'm currently experimenting with the prio_tree code in an elevator
("IO scheduler"), and I'm thinking about a way to avoid code
duplication.

The most straightforward approach seems to be to put everything
after prio_tree_init and before vma_prio_tree_add into a new file,
and #include that file. (And prio_tree_init should be shared.)

#including a .c file normally isn't exactly considered an epitome
of elegance, but in this case, there doesn't seem to be much of a
choice.

There's another issue: in the elevator, entries overlap only
rarely if at all, and it is sometimes useful to walk the tree in
sort order. As far as I can tell, RPSTs can be walked just like
RB trees if there are no overlaps on the path from the current to
the respective adjacent node.

Unfortunately, "prio_tree_next" is already taken. It would be nice
to follow the same naming scheme as RB trees, so perhaps
prio_tree_next could become prio_tree_more, or such ?

What do you think ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
