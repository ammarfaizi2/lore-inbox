Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314630AbSDTPMn>; Sat, 20 Apr 2002 11:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314632AbSDTPMm>; Sat, 20 Apr 2002 11:12:42 -0400
Received: from dsl-213-023-039-128.arcor-ip.net ([213.23.39.128]:60808 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314630AbSDTPMi>;
	Sat, 20 Apr 2002 11:12:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Fri, 19 Apr 2002 17:12:33 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ya3u-0000RG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I have up to this point been open to the use of Bitkeeper as a development
aid for Linux, and, again up to this point, have intended to make use of 
Bitkeeper myself, taking a pragmatic attitude towards the concept of using 
the best tool for the job.  However, now I see that Bitkeeper documentation 
has quietly been inserted ino the Linux Documentation directory, and that 
without any apparent discussion on lkml.  I fear that this demonstrates that 
those who have called the use of Bitkeeper a slippery slope do have a point 
after all.

I respectfully request that you consider applying the attached patch, which 
reverses these proprietary additions to the Documentation directory.  Perhaps 
a better place for this documentation would be on kernel.org if Peter Anvin 
agrees, or the submitter's own site if he does not.  Or perhaps bitkeeper.com 
would be willing to host these files.

Please do not misinterpret my position: I count Larry as something more than 
a personal acquaintance.  I strongly support his efforts to build a business 
for himself out of his Bitkeeper creation.  I even like Jeff Garzik's
documentation, the subject of this patch.  I do not support the infusion of 
documentation for proprietary software products into the Linux tree.  The 
message is that we have gone beyond optional usage of Bitkeeper here, and it 
is now an absolute requirement, or it is on the way there.

I hope that this proposed patch will receive more discussion than the 
original additions to Documentation did.

Thankyou,

Daniel

diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/bk-kernel-howto.txt linux-2.5.8/Documentation/BK-usage/bk-kernel-howto.txt
--- linux-2.5.8.clean/Documentation/BK-usage/bk-kernel-howto.txt	Sun Apr 14 15:18:43 2002
+++ linux-2.5.8/Documentation/BK-usage/bk-kernel-howto.txt	Wed Dec 31 19:00:00 1969
@@ -1,275 +0,0 @@
-
-		   Doing the BK Thing, Penguin-Style
-
-
-
-
-This set of notes is intended mainly for kernel developers, occasional
-or full-time, but sysadmins and power users may find parts of it useful
-as well.  It assumes at least a basic familiarity with CVS, both at a
-user level (use on the cmd line) and at a higher level (client-server model).
-Due to the author's background, an operation may be described in terms
-of CVS, or in terms of how that operation differs from CVS.
-
-This is -not- intended to be BitKeeper documentation.  Always run
-"bk help <command>" or in X "bk helptool <command>" for reference
-documentation.
-
-
-BitKeeper Concepts
-------------------
-
-In the true nature of the Internet itself, BitKeeper is a distributed
-system.  When applied to revision control, this means doing away with
-client-server, and changing to a parent-child model... essentially
-peer-to-peer.  On the developer's end, this also represents a
-fundamental disruption in the standard workflow of changes, commits,
-and merges.  You will need to take a few minutes to think about
-how to best work under BitKeeper, and re-optimize things a bit.
-In some sense it is a bit radical, because it might described as
-tossing changes out into a maelstrom and having them them magically
-land at the right destination... but I'm getting ahead of myself.
-
-Let's start with this progression:
-Each BitKeeper source tree on disk is a repository unto itself.
-Each repository has a parent.
-Each repository contains a set of a changsets ("csets").
-Each cset is one or more changed files, bundled together.
-
-Each tree is a repository, so all changes are checked into the local
-tree.  When a change is checked in, all modified files are grouped
-into a logical unit, the changeset.  Internally, BK links these
-changesets in a tree, representing various converging and diverging
-lines of development.  These changesets are the bread and butter of
-the BK system.
-
-After the concept of changesets, the next thing you need to get used
-to having multiple copies of source trees lying around.  This -really-
-takes some getting used to, for some people.  Separate source trees
-are the means in BitKeeper by which you delineate parallel lines
-of development, both minor and major.  What would be branches in
-CVS become separate source trees, or "clones" in BitKeeper [heh,
-or Star Wars] terminology.
-
-Clones and changesets are the tools from which most of the power of
-BitKeeper is derived.  As mentioned earlier, each clone has a parent,
-the tree used as the source when the new clone was created.  In a
-CVS-like setup, the parent would be a remote server on the Internet,
-and the child is your local clone of that tree.
-
-Once you have established a common baseline between two source trees --
-a common parent -- then you can merge changesets between those two
-trees with ease.  Merging changes into a tree is called a "pull", and
-is analagous to 'cvs update'.  A pull downloads all the changesets in
-the remote tree you do not have, and merges them.  Sending changes in
-one tree to another tree is called a "push".  Push sends all changes
-in the local tree the remote does not yet have, and merges them.
-
-From these concepts come some initial command examples:
-
-1) bk clone -q http://linux.bkbits.net/linux-2.5 linus-2.5
-Download a 2.5 stock kernel tree, naming it "linus-2.5" in the local dir.
-The "-q" disables listing every single file as it is downloaded.
-
-2) bk clone -ql linus-2.5 alpha-2.5
-Create a separate source tree for the Alpha AXP architecture.
-The "-l" uses hard links instead of copying data, since both trees are
-on the local disk.  You can also replace the above with "bk lclone -q ..."
-
-You only clone a tree -once-.  After cloning the tree lives a long time
-on disk, being updating by pushes and pulls.
-
-3) cd alpha-2.5 ; bk pull http://gkernel.bkbits.net/alpha-2.5
-Download changes in "alpha-2.5" repository which are not present
-in the local repository, and merge them into the source tree.
-
-4) bk -r co -q
-Because every tree is a repository, files must be checked out before
-they will be in their standard places in the source tree.
-
-5)	bk vi fs/inode.c				# example change...
-	bk citool					# checkin, using X tool
-	bk push bk://gkernel@bkbits.net/alpha-2.5	# upload change
-Typical example of a BK sequence that would replace the analagous CVS
-situation,
-	vi fs/inode.c
-	cvs commit
-
-As this is just supposed to be a quick BK intro, for more in-depth
-tutorials, live working demos, and docs, see http://www.bitkeeper.com/
-
-
-
-BK and Kernel Development Workflow
-----------------------------------
-Currently the latest 2.5 tree is available via "bk clone $URL"
-and "bk pull $URL" at http://linux.bkbits.net/linux-2.5
-This should change in a few weeks to a kernel.org URL.
-
-
-A big part of using BitKeeper is organizing the various trees you have
-on your local disk, and organizing the flow of changes among those
-trees, and remote trees.  If one were to graph the relationships between
-a desired BK setup, you are likely to see a few-many-few graph, like
-this:
-
-		    linux-2.5
-		        |
-	       merge-to-linus-2.5
-		 /    |      |
-	        /     |      |
-	vm-hacks  bugfixes  filesys   personal-hacks
-	      \	      |	     |		/
-	       \      |      |         /
-		\     |      |        /
-	         testing-and-validation
-
-Since a "bk push" sends all changes not in the target tree, and
-since a "bk pull" receives all changes not in the source tree, you want
-to make sure you are only pushing specific changes to the desired tree,
-not all changes from "peer parent" trees.  For example, pushing a change
-from the testing-and-validation tree would probably be a bad idea,
-because it will push all changes from vm-hacks, bugfixes, filesys, and
-personal-hacks trees into the target tree.
-
-One would typically work on only one "theme" at a time, either
-vm-hacks or bugfixes or filesys, keeping those changes isolated in
-their own tree during development, and only merge the isolated with
-other changes when going upstream (to Linus or other maintainers) or
-downstream (to your "union" trees, like testing-and-validation above).
-
-It should be noted that some of this separation is not just recommended
-practice, it's actually [for now] -enforced- by BitKeeper.  BitKeeper
-requires that changesets maintain a certain order, which is the reason
-that "bk push" sends all local changesets the remote doesn't have.  This
-separation may look like a lot of wasted disk space at first, but it
-helps when two unrelated changes may "pollute" the same area of code, or
-don't follow the same pace of development, or any other of the standard
-reasons why one creates a development branch.
-
-Small development branches (clones) will appear and disappear:
-
-	-------- A --------- B --------- C --------- D -------
-	          \                                 /
-		   -----short-term devel branch-----
-
-While long-term branches will parallel a tree (or trees), with period
-merge points.  In this first example, we pull from a tree (pulls,
-"\") periodically, such a what occurs when tracking changes in a
-vendor tree, never pushing changes back up the line:
-
-	-------- A --------- B --------- C --------- D -------
-	          \                       \           \
-	           ----long-term devel branch-----------------
-
-And then a more common case in Linux kernel development, a long term
-branch with periodic merges back into the tree (pushes, "/"):
-
-	-------- A --------- B --------- C --------- D -------
-	          \                       \         / \
-	           ----long-term devel branch-----------------
-
-
-
-
-
-Submitting Changes to Linus
----------------------------
-There's a bit of an art, or style, of submitting changes to Linus.
-Since Linus's tree is now (you might say) fully integrated into the
-distributed BitKeeper system, there are several prerequisites to
-properly submitting a BitKeeper change.  All these prereq's are just
-general cleanliness of BK usage, so as people become experts at BK, feel
-free to optimize this process further (assuming Linus agrees, of
-course).
-
-
-
-0) Make sure your tree was originally cloned from the linux-2.5 tree
-created by Linus.  If your tree does not have this as its ancestor, it
-is impossible to reliably exchanges changesets.
-
-
-
-1) Pay attention to your commit text.  The commit message that
-accompanies each changeset you submit will live on forever in history,
-and is used by Linus to accurately summarize the changes in each
-pre-patch.  Remember that there is no context, so
-	"fix for new scheduler changes"
-would be too vague, but
-	"fix mips64 arch for new scheduler switch_to(), TIF_xxx semantics"
-would be much better.
-
-You can and should use the command "bk comment -C<rev>" to update the
-commit text, and improve it after the fact.  This is very useful for
-development: poor, quick descriptions during development, which get
-cleaned up using "bk comment" before issuing the "bk push" to submit the
-changes.
-
-
-
-2) Include an Internet-available URL for Linus to pull from, such as
-
-	Pull from:  http://gkernel.bkbits.net/net-drivers-2.5
-
-
-
-3) Include a summary and "diffstat -p1" of each changeset that will be
-downloaded, when Linus issues a "bk pull".  The author auto-generates
-these summaries using "bk push -nl <parent> 2>&1", to obtain a listing
-of all the pending-to-send changesets, and their commit messages.
-
-It is important to show Linus what he will be downloading when he issues
-a "bk pull", to reduce the time required to sift the changes once they
-are downloaded to Linus's local machine.
-
-IMPORTANT NOTE:  One of the features of BK is that your repository does
-not have to be up to date, in order for Linus to receive your changes.
-It is considered a courtesy to keep your repository fairly recent, to
-lessen any potential merge work Linus may need to do.
-
-
-4) Split up your changes.  Each maintainer<->Linus situation is likely
-to be slightly different here, so take this just as general advice.  The
-author splits up changes according to "themes" when merging with Linus.
-Simultaneous pushes from local development to goes special trees which
-exist solely to house changes "queued" for Linus.  Example of the trees:
-
-	net-drivers-2.5 -- on-going net driver maintenance
-	vm-2.5 -- VM-related changes
-	fs-2.5 -- filesystem-related changes
-
-Linus then has much more freedom for pulling changes.  He could (for
-example) issue a "bk pull" on vm-2.5 and fs-2.5 trees, to merge their
-changes, but hold off net-drivers-2.5 because of a change that needs
-more discussion.
-
-Other maintainers may find that a single linus-pull-from tree is
-adequate for passing BK changesets to him.
-
-
-
-Frequently Answered Questions
------------------------------
-1) How do I change the e-mail address shown in the changelog?
-A. When you run "bk citool" or "bk commit", set environment
-   variables BK_USER and BK_HOST to the desired username
-   and host/domain name.
-
-
-2) How do I use tags / get a diff between two kernel versions?
-A. Pass the tags Linus uses to 'bk export'.
-
-ChangeSets are in a forward-progressing order, so it's pretty easy
-to get a snapshot starting and ending at any two points in time.
-Linus puts tags on each release and pre-release, so you could use
-these two examples:
-
-    bk export -tpatch -hdu -rv2.5.4,v2.5.5 | less
-        # creates patch-2.5.5 essentially
-    bk export -tpatch -du -rv2.5.5-pre1,v2.5.5 | less
-        # changes from pre1 to final
-
-A tag is just an alias for a specific changeset... and since changesets
-are ordered, a tag is thus a marker for a specific point in time (or
-specific state of the tree).
diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/bk-make-sum linux-2.5.8/Documentation/BK-usage/bk-make-sum
--- linux-2.5.8.clean/Documentation/BK-usage/bk-make-sum	Sun Apr 14 15:18:45 2002
+++ linux-2.5.8/Documentation/BK-usage/bk-make-sum	Wed Dec 31 19:00:00 1969
@@ -1,37 +0,0 @@
-#!/bin/sh -e
-# DIR=$HOME/BK/axp-2.5
-# cd $DIR
-
-LINUS_REPO=$1
-DIRBASE=`basename $PWD`
-
-{
-cat <<EOT
-Linus, please do a
-
-	bk pull http://gkernel.bkbits.net/$DIRBASE
-
-This will update the following files:
-
-EOT
-
-bk changes -L -d'$unless(:MERGE:){:CSETREV:\n}' $LINUS_REPO |
-while read rev; do
-  bk export -tpatch -r$rev
-done | diffstat -p1 2>/dev/null
-
-cat <<EOT
-
-through these ChangeSets:
-
-EOT
-
-bk changes -L -d'$unless(:MERGE:){ChangeSet|:CSETREV:\n}' $LINUS_REPO |
-bk -R prs -h -d'$unless(:MERGE:){<:P:@:HOST:> (:D: :I:)\n$each(:C:){   (:C:)\n}\n}' -
-
-} > /tmp/linus.txt
-
-cat <<EOT
-Mail text in /tmp/linus.txt; please check and send using your favourite
-mailer.
-EOT
diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/bksend linux-2.5.8/Documentation/BK-usage/bksend
--- linux-2.5.8.clean/Documentation/BK-usage/bksend	Sun Apr 14 15:18:48 2002
+++ linux-2.5.8/Documentation/BK-usage/bksend	Wed Dec 31 19:00:00 1969
@@ -1,36 +0,0 @@
-#!/bin/sh
-# A script to format BK changeset output in a manner that is easy to read.
-# Andreas Dilger <adilger@turbolabs.com>  13/02/2002
-#
-# Add diffstat output after Changelog <adilger@turbolabs.com>   21/02/2002
-
-PROG=bksend
-
-usage() {
-	echo "usage: $PROG -r<rev>"
-	echo -e "\twhere <rev> is of the form '1.23', '1.23..', '1.23..1.27',"
-	echo -e "\tor '+' to indicate the most recent revision"
-
-	exit 1
-}
-
-case $1 in
--r) REV=$2; shift ;;
--r*) REV=`echo $1 | sed 's/^-r//'` ;;
-*) echo "$PROG: no revision given, you probably don't want that";;
-esac
-
-[ -z "$REV" ] && usage
-
-echo "You can import this changeset into BK by piping this whole message to:"
-echo "'| bk receive [path to repository]' or apply the patch as usual."
-
-SEP="\n===================================================================\n\n"
-echo -e $SEP
-bk changes -r$REV
-echo
-bk export -tpatch -du -h -r$REV | diffstat
-echo; echo
-bk export -tpatch -du -h -r$REV
-echo -e $SEP
-bk send -wgzip_uu -r$REV -
diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/bz64wrap linux-2.5.8/Documentation/BK-usage/bz64wrap
--- linux-2.5.8.clean/Documentation/BK-usage/bz64wrap	Sun Apr 14 15:18:55 2002
+++ linux-2.5.8/Documentation/BK-usage/bz64wrap	Wed Dec 31 19:00:00 1969
@@ -1,41 +0,0 @@
-#!/bin/sh
-
-# bz64wrap - the sending side of a bzip2 | base64 stream
-# Andreas Dilger <adilger@clusterfs.com>   Jan 2002
-
-
-PATH=$PATH:/usr/bin:/usr/local/bin:/usr/freeware/bin
-
-# A program to generate base64 encoding on stdout
-BASE64_ENCODE="uuencode -m /dev/stdout"
-BASE64_BEGIN=
-BASE64_END=
-
-BZIP=NO
-BASE64=NO
-
-# Test if we have the bzip program installed
-bzip2 -c /dev/null > /dev/null 2>&1 && BZIP=YES
-
-# Test if uuencode can handle the -m (MIME) encoding option
-$BASE64_ENCODE < /dev/null > /dev/null 2>&1 && BASE64=YES
-
-if [ $BASE64 = NO ]; then
-	BASE64_ENCODE=mimencode
-	BASE64_BEGIN="begin-base64 644 -"
-	BASE64_END="===="
-
-	$BASE64_ENCODE < /dev/null > /dev/null 2>&1 && BASE64=YES
-fi
-
-if [ $BZIP = NO -o $BASE64 = NO ]; then
-	echo "$0: can't use bz64 encoding: bzip2=$BZIP, $BASE64_ENCODE=$BASE64"
-	exit 1
-fi
-
-# Sadly, mimencode does not appear to have good "begin" and "end" markers
-# like uuencode does, and it is picky about getting the right start/end of
-# the base64 stream, so we handle this internally.
-echo "$BASE64_BEGIN"
-bzip2 -9 | $BASE64_ENCODE
-echo "$BASE64_END"
diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/cset-to-linus linux-2.5.8/Documentation/BK-usage/cset-to-linus
--- linux-2.5.8.clean/Documentation/BK-usage/cset-to-linus	Sun Apr 14 15:18:45 2002
+++ linux-2.5.8/Documentation/BK-usage/cset-to-linus	Wed Dec 31 19:00:00 1969
@@ -1,49 +0,0 @@
-#!/usr/bin/perl -w
-
-use strict;
-
-my ($lhs, $rev, $tmp, $rhs, $s);
-my @cset_text = ();
-my @pipe_text = ();
-my $have_cset = 0;
-
-while (<>) {
-	next if /^---/;
-
-	if (($lhs, $tmp, $rhs) = (/^(ChangeSet\@)([^,]+)(, .*)$/)) {
-		&cset_rev if ($have_cset);
-
-		$rev = $tmp;
-		$have_cset = 1;
-
-		push(@cset_text, $_);
-	}
-
-	elsif ($have_cset) {
-		push(@cset_text, $_);
-	}
-}
-&cset_rev if ($have_cset);
-exit(0);
-
-
-sub cset_rev {
-	my $empty_cset = 0;
-
-	open PIPE, "bk export -tpatch -hdu -r $rev | diffstat -p1 2>/dev/null |" or die;
-	while ($s = <PIPE>) {
-		$empty_cset = 1 if ($s =~ /0 files changed/);
-		push(@pipe_text, $s);
-	}
-	close(PIPE);
-
-	if (! $empty_cset) {
-		print @cset_text;
-		print @pipe_text;
-		print "\n\n";
-	}
-
-	@pipe_text = ();
-	@cset_text = ();
-}
-
diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/csets-to-patches linux-2.5.8/Documentation/BK-usage/csets-to-patches
--- linux-2.5.8.clean/Documentation/BK-usage/csets-to-patches	Sun Apr 14 15:18:56 2002
+++ linux-2.5.8/Documentation/BK-usage/csets-to-patches	Wed Dec 31 19:00:00 1969
@@ -1,44 +0,0 @@
-#!/usr/bin/perl -w
-
-use strict;
-
-my ($lhs, $rev, $tmp, $rhs, $s);
-my @cset_text = ();
-my @pipe_text = ();
-my $have_cset = 0;
-
-while (<>) {
-	next if /^---/;
-
-	if (($lhs, $tmp, $rhs) = (/^(ChangeSet\@)([^,]+)(, .*)$/)) {
-		&cset_rev if ($have_cset);
-
-		$rev = $tmp;
-		$have_cset = 1;
-
-		push(@cset_text, $_);
-	}
-
-	elsif ($have_cset) {
-		push(@cset_text, $_);
-	}
-}
-&cset_rev if ($have_cset);
-exit(0);
-
-
-sub cset_rev {
-	my $empty_cset = 0;
-
-	system("bk export -tpatch -du -r $rev > /tmp/rev-$rev.patch");
-
-	if (! $empty_cset) {
-		print @cset_text;
-		print @pipe_text;
-		print "\n\n";
-	}
-
-	@pipe_text = ();
-	@cset_text = ();
-}
-
diff -uN --recursive linux-2.5.8.clean/Documentation/BK-usage/unbz64wrap linux-2.5.8/Documentation/BK-usage/unbz64wrap
--- linux-2.5.8.clean/Documentation/BK-usage/unbz64wrap	Sun Apr 14 15:18:52 2002
+++ linux-2.5.8/Documentation/BK-usage/unbz64wrap	Wed Dec 31 19:00:00 1969
@@ -1,25 +0,0 @@
-#!/bin/sh
-
-# unbz64wrap - the receiving side of a bzip2 | base64 stream
-# Andreas Dilger <adilger@clusterfs.com>   Jan 2002
-
-# Sadly, mimencode does not appear to have good "begin" and "end" markers
-# like uuencode does, and it is picky about getting the right start/end of
-# the base64 stream, so we handle this explicitly here.
-
-PATH=$PATH:/usr/bin:/usr/local/bin:/usr/freeware/bin
-
-if mimencode -u < /dev/null > /dev/null 2>&1 ; then
-	SHOW=
-	while read LINE; do
-		case $LINE in
-		begin-base64*) SHOW=YES ;;
-		====) SHOW= ;;
-		*) [ "$SHOW" ] && echo $LINE ;;
-		esac
-	done | mimencode -u | bunzip2
-	exit $?
-else
-	cat - | uudecode -o /dev/stdout | bunzip2
-	exit $?
-fi
