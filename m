Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUGECIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUGECIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 22:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUGECIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 22:08:00 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:53937 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S265905AbUGECH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 22:07:57 -0400
Date: Mon, 5 Jul 2004 04:07:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Werner Almesberger <wa@almesberger.net>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: prio_tree generalization
Message-ID: <20040705020740.GA3246@dualathlon.random>
References: <20040704222438.A11865@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704222438.A11865@almesberger.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 10:24:38PM -0300, Werner Almesberger wrote:
> Hi Rajesh,
> 
> I'm currently experimenting with the prio_tree code in an elevator
> ("IO scheduler"), and I'm thinking about a way to avoid code
> duplication.

that's a nice effort, I agree prio_tree.c is better suited for lib/ than
mm/ but the code already looks quite generic and well written.

>
> The most straightforward approach seems to be to put everything
> after prio_tree_init and before vma_prio_tree_add into a new file,
> and #include that file. (And prio_tree_init should be shared.)
> 
> #including a .c file normally isn't exactly considered an epitome
> of elegance, but in this case, there doesn't seem to be much of a
> choice.

why don't you move the shared code to lib/prio_tree.c instead of
duplicating it in every object?
prio_tree_insert/prio_tree_remove/prio_tree_replace needs to be
exported etc..

> There's another issue: in the elevator, entries overlap only
> rarely if at all, and it is sometimes useful to walk the tree in
> sort order. As far as I can tell, RPSTs can be walked just like
> RB trees if there are no overlaps on the path from the current to
> the respective adjacent node.
> 
> Unfortunately, "prio_tree_next" is already taken. It would be nice
> to follow the same naming scheme as RB trees, so perhaps
> prio_tree_next could become prio_tree_more, or such ?

I thought prio_tree_next was already the equivalent of rb_next for
prio-trees. The API is slightly different because you need an iterator
object, but I'm not sure how you want to change it to make it more
symmetric with rb_next.
