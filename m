Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269148AbTCDFTy>; Tue, 4 Mar 2003 00:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269149AbTCDFTy>; Tue, 4 Mar 2003 00:19:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40453 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269148AbTCDFTt>; Tue, 4 Mar 2003 00:19:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Date: Tue, 4 Mar 2003 05:29:33 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b41djt$2s2$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com> <592860000.1046744403@flay>
X-Trace: palladium.transmeta.com 1046755797 6270 127.0.0.1 (4 Mar 2003 05:29:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Mar 2003 05:29:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <592860000.1046744403@flay>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
>>> Just curious, this also means that at least around the 80% of merges
>>> in Linus's tree is submitted via a bitkeeper pull, right?
>>> 
>>> Andrea
>> 
>> remember how Linus works, all normal patches get copied into a single
>> large patch file as he reads his mail then he runs patch to apply them to
>> the tree. I think this would make the entire batch of messages look like
>> one cset.

Nope. All my tools are very careful about making single cset's from
single patches. Without that, you can't get good history and changelog
files, and you can't undo or test single patches.

What I _do_ do is to "batch up" patches, which you can see if you take a
look at the times for various changesets. I will save many emails to one
single "pending" file (I call it "doit"), and then my tools will apply
each of them in sequence as one "batch" of files. You can see the effect
of this by just doing

	bk changes | grep ChangeSet | less

and seeing how the changes are just a few seconds apart. For example,
here's the last batch I have from Andrew, and you can see that my
scripts applied 19 patches in sequence:

	ChangeSet@1.1058, 2003-03-02 20:38:36-08:00, akpm@digeo.com
	ChangeSet@1.1057, 2003-03-02 20:38:23-08:00, akpm@digeo.com
	ChangeSet@1.1056, 2003-03-02 20:38:15-08:00, akpm@digeo.com
	ChangeSet@1.1055, 2003-03-02 20:38:09-08:00, akpm@digeo.com
	ChangeSet@1.1054, 2003-03-02 20:38:02-08:00, akpm@digeo.com
	ChangeSet@1.1053, 2003-03-02 20:37:54-08:00, akpm@digeo.com
	ChangeSet@1.1052, 2003-03-02 20:37:48-08:00, akpm@digeo.com
	ChangeSet@1.1051, 2003-03-02 20:37:41-08:00, akpm@digeo.com
	ChangeSet@1.1050, 2003-03-02 20:37:34-08:00, akpm@digeo.com
	ChangeSet@1.1049, 2003-03-02 20:37:26-08:00, akpm@digeo.com
	ChangeSet@1.1048, 2003-03-02 20:37:19-08:00, akpm@digeo.com
	ChangeSet@1.1047, 2003-03-02 20:37:13-08:00, akpm@digeo.com
	ChangeSet@1.1046, 2003-03-02 20:37:07-08:00, akpm@digeo.com
	ChangeSet@1.1045, 2003-03-02 20:36:59-08:00, akpm@digeo.com
	ChangeSet@1.1044, 2003-03-02 20:36:51-08:00, akpm@digeo.com
	ChangeSet@1.1043, 2003-03-02 20:36:44-08:00, akpm@digeo.com
	ChangeSet@1.1042, 2003-03-02 20:36:38-08:00, akpm@digeo.com
	ChangeSet@1.1041, 2003-03-02 20:36:31-08:00, akpm@digeo.com
	ChangeSet@1.1040, 2003-03-02 20:36:23-08:00, akpm@digeo.com

roughly 8 seconds between patch (that's how long it takes the scripts to
commit between each change.  Imagine doing a commit in 8 seconds using
CVS..)

But all 19 emails ended up as separate changesets, and the only thing
the "batching" does is to make _me_ work more efficiently (ie I don't go
back and forth between reading email and applying one patch: I save the
batch away, I then look through the patches individually and possibly
edit and clean up the email commentary on it, and then I apply them all
in one go). 

>I think he also creates subtrees, applies flat patches to those, then 
>merges the subtrees back into his main tree as a bk-merge ... won't that 
>distort the stats? 

Yes, it will. 

I try to generally avoid doing parallell development with myself, partly
because it ends up _looking_ really confusing in revtool and thus
sometimes hard to find stuff, but partly just because I'm lazy and I
consider my main tree to be the "merge tree", so by default everything
_should_ go into that one tree if I really do want to merge it.

However, sometimes I get a big series of patches that was generated
against some specific kernel version, and then I'll set up a parallell
tree with the top at that specific version, so that I re-create exactly
what the original developer was working on. That way I avoid patch
rejects, and can take advantage of the automatic BK merge features.

It's not that common, though - I do it mostly if I know or suspect that
something will clash with existing changes in my tree, or if it's
something so fundamental that I want a separate branch for it (this was
the case for a lot of the fundamental VFS stuff Al Viro did earlier in
2.5.x, for example).

			Linus
