Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVDGC0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVDGC0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVDGC0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:26:43 -0400
Received: from main.gmane.org ([80.91.229.2]:58785 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262388AbVDGC0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:26:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: Kernel SCM saga..
Date: Thu, 07 Apr 2005 12:26:03 +1000
Message-ID: <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net> <20050407014727.GA17970@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 57.16.168.202.velocitynet.com.au
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2005 21:47:27 -0400, Jeff Garzik wrote:

>> The operations that are already done are pretty fast: ~60s to import a
>> kernel tree, ~10s to import a new revision from a patch.
> 
> By "importing", are you saying that importing all 60,000+ changesets of
> the current kernel tree took only 60 seconds?

Now that would be impressive.

No, I mean this:

 % bzcat ../linux.pkg/patch-2.5.14.bz2| patch -p1 

 % time bzr add -v .   
 (find any new non-ignored files; deleted files automatically noticed) 
 6.06s user 0.41s system 89% cpu 7.248 total

 % time bzr commit -v -m 'import 2.5.14'
 7.71s user 0.71s system 65% cpu 12.893 total

(OK, a bit slower in this case but it wasn't all in core.)

This is only v0.0.3, but I think the interface simplicity and speed
compares well.

I haven't tested importing all 60,000+ changesets of the current bk tree,
partly because I don't *have* all those changesets.  (Larry said
previously that someone (not me) tried to pull all of them using bkclient,
and he considered this abuse and blacklisted them.)

I have been testing pulling in release and rc patches, and it scales to
that level.  It probably could not handle 60,000 changesets yet, but there
is a plan to get there.  In the interim, although it cannot handle the
whole history forever it can handle large trees with moderate numbers of
commits -- perhaps as many as you might deal with in developing a feature
over a course of a few months.

The most sensible place to try out bzr, if people want to, is as a way to
keep your own revisions before mailing a patch to linus or the subsystem
maintainer.

-- 
Martin


