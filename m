Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751727AbWAJAKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWAJAKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWAJAKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:10:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751727AbWAJAJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:09:58 -0500
Date: Mon, 9 Jan 2006 16:09:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH updated]: How to be a kernel driver maintainer
In-Reply-To: <1136842100.2936.34.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0601091600500.5588@g5.osdl.org>
References: <1136736455.24378.3.camel@grayson>  <1136756756.1043.20.camel@grayson>
  <1136792769.2936.13.camel@laptopd505.fenrus.org>  <1136813649.1043.30.camel@grayson>
 <1136842100.2936.34.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Arjan van de Ven wrote:
> 
> > Obviously, they have to do their work, and their development on
> > something that isn't in Linus tree. If they are doing this work, they
> > need to make sure that when they diff for patches, that they merge
> > changes before diffing. The only way this is close to automatic is with
> > git. Any other method requires manually merging.
> 
> not correct. quilt is a very excellent counter example of that.

Yes. Anything that keeps a nice patch series that you can merge as a nice 
patch series works fine.

For example, Al Viro used to use (still uses?) RCS to maintain his 
work-in-progress. That worked fine, because he had a process where he 
would just extract them as patches.

The reason CVS doesn't work well is partly because CVS just sucks at so 
many levels, and because people start using it as more than a "series of 
patches" repository. People might cherry-pick one or two changes from a 
CVS, but it quickly becomes totally impossible to do anything sane at all, 
or even to cherry-pick more than a few patches, because after a while 
you've lost the ability to pick out individual changes.

Something like quilt works fine, because individual patches never get lost 
in other patches (they might get merged with another patch on purpose, but 
that's a separate issue). Anything that understands the notion of 
changesets and can be taught to re-order them should be able to work the 
same way.

So the important thing is to have _some_ proper linear changeset history, 
preferably one where you can re-order them (so that if you cherry-pick a 
set of changesets, you can mark them as having been merged, and keep the 
_rest_ as a linear changeset history).

CVS just sucks. End of story. It works badly at so many levels that it's 
just not even funny.

		Linus
