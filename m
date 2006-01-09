Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWAIWvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWAIWvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWAIWvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:51:48 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:41112 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751615AbWAIWvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:51:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nqIV8+ksllUnucJtEHAWNLgy32BYmiyoEK9eg7lGP6P2u0hXbcnjlg0XR/K/c1Cy9H5jy19425bh0vvILWHt4sbXq7x9ToHXGm4SoJztLdxwUmFkBK4j+zXZ5iHUwnqTG3QwvcaHhTwGQ8wdS4Hzd3RK7YyOU8JtkNGRp21ee34=  ;
Message-ID: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
Date: Mon, 9 Jan 2006 14:51:43 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: RE: git pull on Linux/ACPI release tree
To: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       Martin Langhoff <martin.langhoff@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601090850350.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote:
> But if there are workflow problems, let's try to fix them. The "apply 
> patches directly to another branch" suggestion may not be sane (maybe it's 
> too confusing to apply a patch and not actually see it in the working 
> tree), but workflow suggestions in general are appreciated.

This is sensible, thank you.

A very general workflow I've seen people use is more/less as
I outlined in my previous email:

  tree A  (linus' or trunk)
     Project B  (Tree B)
        Project C  (Tree C, depending on stuff in Project B)

Now this could be how the "managers" see things, but development,
could've "cloned" from Tree B and Tree C further, as is often
customary to have a a) per user tree, or b) per bug tree.

So pull/merge/fetch/whatever follows Tree A->B->C.

It is sensible to have another tree say, called something
like "for_linus" or "upstream" or "product" which includes
what has accumulated in C from B and in B from A, (eq diff(C-A)).
I.e. a "push" tree.  So that I can tell you, "hey,
pull/fetch/merge/whatever the current verb en vogue is, from
here to get latest xyz".

What I also wanted to mention is that Tree B undeniably
depends on the _latest_ state of Tree A, since Project B
uses API/behaviour of the code in Tree A, so one cannot just
say they are independent.  Similarly for Tree C/Project C,
is dependent on B, and dependent on A.

Also sometimes a bugfix in C, prompts a bugfix in A,
so that the bugfix in A doesn't apply unless the bugfix in C.
(To get things more complicated.)

I think this is more/less the most easier to see, understand and
follow workflow approach, which is also the case for other SCMs.

What are the commands to follow to make everyone happy when
pulling from such a development process?

FWIW, "git diff A C | send to Linus" would get you the
"no merge messages/ancestors I want to see" idea, if I understand
this thread correctly.

> We've made switching branches about as efficient as it can be (but if the 
> differences are huge, the cost of re-writing the working directory is 
> never going to be low). But switching branches has the "confusion factor" 
> (ie you forget which branch you're on, and apply a patch to your working 
> branch instead of your development branch), so maybe there are other ways 
> of doing the same thing that might be sensible..

Yes.  Ever since I started used git, I never used branch
switching, but I do have git branches and I do use git branching.

I basically have a branch per directory, whereby the object db
is shared as is remotes/refs/etc, HEAD and index are not shared
of course.

This allows me to do a simple and fast "cd" to change/go to a
different branch, since they are in different directories.
So the time I wait to switch branches is the time the filesystem
takes to do a "cd".

This also allows me to build/test/patch/work on branches
simultaneously.

Thank you,
   Luben

