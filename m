Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVDHIp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVDHIp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVDHIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:45:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39502
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262736AbVDHIpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:45:05 -0400
Date: Fri, 8 Apr 2005 10:38:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408083839.GC3957@opteron.random>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net> <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net> <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:41:29PM -0700, Linus Torvalds wrote:
> I know I can import things myself, but the reason I ask is because I've
> got several SCM's I should check out _and_ I've been spending the last two
> days writing my own fallback system so that I don't get screwed if nothing
> out there works right now. 

I tend to like bzr too (and I tend to like too many things ;), but even
if the export of the data would be available it seems still too early in
development to be able to help you this week, it seems to miss any form
of network export too.

> I'd like many people to test out many alternatives, to get a feel for 
> where they are especially for a project the size of the kernel..

The huge number of changesets is the crucial point, there are good
distributed SCM already but they are apparently not efficient enough at
handling 60k changesets.

We'd need a regenerated coherent copy of BKCVS to pipe into those SCM to
evaluate how well they scale.

OTOH if your git project already allows storing the data in there,
that looks nice ;). I don't yet fully understand how the algorithms of
the trees are meant to work (I only understand well the backing store
and I tend to prefer DBMS over tree of dirs with hashes). So I've no
idea how it can plug in well for a SCM replacement or how you want to
use it. It seems a kind of fully lockless thing where you can merge from
one tree to the other without locks and where you can make quick diffs.
It looks similar to a diff -ur of two hardlinked trees, except this one
can save a lot of bandwidth to copy with rsync (i.e.  hardlinks becomes
worthless after using rsync in the network, but hashes not). Clearly the
DBMS couldn't use the rsync binary to distribute the objects, but a
network protocol could do the same thing rsync does.

Thanks.
