Return-Path: <linux-kernel-owner+w=401wt.eu-S1947243AbWLHUut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947243AbWLHUut (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947223AbWLHUut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:50:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35498 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947243AbWLHUus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:50:48 -0500
Date: Fri, 8 Dec 2006 12:50:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Artem Bityutskiy <dedekind@yandex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm tree and git
Message-Id: <20061208125045.be3155c8.akpm@osdl.org>
In-Reply-To: <45796CF9.3050702@yandex.ru>
References: <45796CF9.3050702@yandex.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 15:47:37 +0200
Artem Bityutskiy <dedekind@yandex.ru> wrote:

> Hello Andrew, community,
> 
> I am not really aware how your -mm tree cooperates with git so I have 
> questions.
> 
> Actually I am talking about the "git-ubi.patch" in your tree. You seems 
> to periodically update the patch by fetching the stuff from the 
> ubi-2.6.git GIT tree.

Yes.  Once per day is typical.

> 1. How do you produce the diff file from the ubi-2.6.git?

I pull Linus's tip-of-tree then I pull your tree then I run git magic to
generate the linus->you diff.  The git magic varies, but is usually

	git reset --hard "$upstream"
	git fetch "$tree" || exit 1
	git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null

	{
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
		git diff --patch-with-stat ORIG_HEAD
	} >$PULL/$tree.patch


> 2. Do you mind if I re-base the ubi-2.6.git from time to time? Does it 
> cause any troubles for you?

No problem at all.  In fact, people do this so often that I now always do a
`git-branch -D' before pulling each tree.

> 3, Are there some special things I should or should not do to make it 
> easy for you to work with the git tree?

The things which cause me trouble are:

- git trees which are based on other people's git trees (eg, git-wireless
  is based on git-netdev-all).

  I have other git-pulling scripts which usually manage to sort this out.

- git trees which have lots of merge rejects

  I'll usually kludge these locally, but maintainers who resync with
  Linus frequently and fix these things up are appreciated.

Problems are rare and you're unlikely to hear from me - just do whatever
you want to do and I'll cope ;)

> 4. I see a 
> "ubi-versus-add-include-linux-freezerh-and-move-definitions-from.patch" 
> patch in your tree. It is related to the stuff which is available in 
> Linus's tree. But my tree does not have it yet. Is is OK if I won't push 
> it for now and do this later when I sync with mainline?

This is a patch I added to -mm to make your tree compile correctly when combined
with a different tree (in this case, -mm itself).  I frequently have such
patches and I will send them to the appropriate developer when it is time
for that developer to merge it (ie: the thing which their tree conflicts
with has been merged into mainline).

In this case, add-include-linux-freezerh-and-move-definitions-from.patch
was merged yesterday, so I sent
ubi-versus-add-include-linux-freezerh-and-move-definitions-from.patch to
you, because you now need it.
