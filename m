Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVDGRpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVDGRpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVDGRpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:45:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:48608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262517AbVDGRpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:45:30 -0400
Date: Thu, 7 Apr 2005 10:47:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <1112858331.6924.17.camel@localhost.localdomain>
 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
 <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Al Viro wrote:
> 
> No.  There's another reason - when you are cherry-picking and reordering
> *your* *own* *patches*.

Yes. I agree. There should be some support for cherry-picking in between a
temporary throw-away tree and a "cleaned-up-tree". However, it should be
something you really do need to think about, and in most cases it really
does boil down to "export as patch, re-import from patch". Especially
since you potentially want to edit things in between anyway when you
cherry-pick.

(I do that myself: If I have been a messy boy, and committed mixed-up 
things as one commit, I export it as a patch, and then I split the patch 
by hand into two or more pieces - sometimes by just editing the patch 
directly, but sometimes with a combination of by applying it, and editing 
the result, and then re-exporting it as the new version).

And in the cases where this happens, you in fact often have unrelated
changes to the _same_file_, so you really do end up having that middle 
step.

In other words, this cherry-picking can generally be scripted and done
"outside" the SCM (you can trivially have a script that takes a revision
from one tree and applies it to the other). I don't believe that the SCM
needs to support it in any fundamentally inherent manner. After all, why 
should it, when it really boilds down to 

	(cd old-tree ; scm export-as-patch-plus-comments) |
		(cd new-tree ; scm import-patch-plus-comments)

where the "patch-plus-comments" part is just basically an extended patch
(including rename information etc, not just the comments).

Btw, this method of cherry-picking again requires two _separate_ active 
trees at the same time. BK is great at that, and really, that's what 
distributed SCM's should be all about anyway. It's not just distributed 
between different machines, it's literally distributed even on the same 
machine, and it's actively _used_ that way.

		Linus
