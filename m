Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbTCKSaP>; Tue, 11 Mar 2003 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbTCKSaP>; Tue, 11 Mar 2003 13:30:15 -0500
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:53663 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S261505AbTCKSaK>;
	Tue, 11 Mar 2003 13:30:10 -0500
Date: Tue, 11 Mar 2003 10:40:43 -0800
From: Zack Brown <zbrown@tumblerings.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030311184043.GA24925@renegade>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade> <20030309225857.0FAC7101207@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309225857.0FAC7101207@mx12.arcor-online.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 12:03:18AM +0100, Daniel Phillips wrote:
> On Sun 09 Mar 03 03:45, Zack Brown wrote:
> > OK, so here is my distillation of Larry's post.
...
> > I'd be willing to maintain this as the beginning of a feature list and
> > post it regularly to lkml if enough people feel it would be useful and not
> > annoying. The goal would be to identify the features/problems that would
> > need to be handled by a kernel-ready version control system.
> >
> > Be well,
> > Zack
> 
> Hi Zack,
> 
> You might want to have a look here, there's lots of good stuff:
> 
>    http://arx.fifthvision.net/bin/view/Arx/LinuxKernel
>    (Kernel Hackers SCM wish list)

Hi,

I remember that discussion. It was pretty interesting, but some
conflicting ideas about what should be done; and not much organization
to it all.

I've taken a lot of stuff from that wish list, combined it with what I gathered
from Larry's earlier post, and from Petr Baudis' recent post, and elsewhere,
and organized it into something that might be interesting. If anyone would
like to host this document on the web, please let me know.

--------------------------------- cut here ---------------------------------

           Linux Kernel Requirements For A Version Control System    

Document version 0.0.1

This document describes the features required for a version control system
that would be acceptable to Linux kernel developers. A second section below
lists features that would also be good, but not required for adoption by the
kernel team.

Please help out by clarifying features; identifying which features are
really required and which would just be nice; and by listing corner cases
and other implementation issues.

                          * * * Basic summary * * *

A distributed, replicated, version controlled user level file system with no
limits on any of the file system events which may happen in parallel. All
changes must be put correctly back together, no matter how much parallelism
there has been.

                   * * * Requirements For The Kernel * * *

                            Distributed Branches

  1. Introduction

The idea of distributed branches is to allow developers to pull an entire,
full-featured repository onto their home system from the 'main' repository,
allow them to work off-line or with other groups of developers without
sacrificing the features of a full repository, then merge their work back to
the main repository or to other repositories.

A 'main' repository in this case is simply a repository used by the project
leader of a given project. It has no special features or privileges missing
from other branches. It is only considered the 'main' repository for social
reasons, not technical ones. Therefore, branches that have been cloned from
the main repository should not have to 'register' with the repository they
cloned from. i.e. one repository should be able to interact fully with
another, without either of them having prior knowledge of the other.

  2. Behavior

Creating one repository from another should produce a full clone; not just
the current state of the parent repository, but all data from the parent
should be included in the child.

When cloning a repository, committing changes back to the parent, or sharing
changes with any other repositories, no assumptions should be made about the
location of the repositories on the network. Repositories may be on the same
machine, or on entirely different machines anywhere in the world.

                                 Changesets

  1. Introduction

A changeset is a group of files in a repository, that have been tagged by
the developer, as being logical parts of a patch dealing with a single
feature or fix. A developer working on multiple aspects of a repository, may
create one changeset for each aspect, in which each changeset consists of
the files relevant to that aspect.

In the context of sharing changesets between repositories, a changeset
consists of a diff between the set of files in the local and remote
repositories.

  2. Behavior

    2.1 Tagging

It must be trivial for a developer to tag a file as part of a given
changeset.

It must be possible to reorganize changesets, so that a given changeset may
be split up into more manageable pieces.

    2.2 Versioning

Changesets are given their own local version number, incremented with each
checkin.

  3. Problems For Clarification

If a file is tagged as being part of two different changesets, then changes
to that file should be associated with which changeset???

                                  Checkins

  1. Introduction

Checkins consist of making local modifications to a given repository. This
is distinct from merging changes from one repository into another. A
developer making local changes to their own repository is doing checkins. A
developer sharing their changes with a separate repository is doing merging.

  2. Behavior

Files that are not part of a changeset are treated individually. On checkin,
the developer may include a comment for each file. This is distinct from
version control systems that take a single comment for the whole checkin.

It must be possible to checkin a single changeset to a local repository, and
have that changeset be treated as an individual unit, just as plain files
are: on checkin, the developer includes a single comment for the entire
changeset.

                                   Merging

  1. Introduction

Merging consists of sending and receiving changes between two or more
repositories.

  2. Behavior

    2.1 Preserving Local Work

It must be possible to update a local repository to match changes that have
been made to a remote repository, while at the same time preserve changes
that have been made to the local repository. If conflicts arise because some
of the same files have changed on both the local and remote repositories,
conflict resolution tools should be automatically invoked for the local
developer (see below).

If a checkin is interrupted for some reason, it should be easy to clean up
the tree, bringing it back to a consistant, useful state.

It should be possible to mark a file as private to a local repository, so
that a merge will never try to commit that file's changes to a remote
repository.

    2.2 Preserving History

Checkin tags and version numbers are local to a given repository. Because
duplicates may exist across repositories, these historical details must be
remapped during checkin, to values that are unique within the remote
repository, but that can still be identified with their originals.

A merge between two repositories does not consist only of merging the
current state of a set of changesets, but their entire history, including
all their versions and the files that comprise them.

Even if no history is available for a given patch, it should be easy to
checkin and merge that patch.

The implementation must not depend on time being accurately reported by any
of the repositories.

  3. Graph Structure

To illustrate some of the above behaviors, see the following DAG (Directed
Acyclic Graph). This graph will look different when viewed from each
repository (diagrams show the ChangeSet numbers). From the imaginary Linus'
branch, it looks like:


linus  1.1 -> 1.2 -> 1.3 -----> 1.4 -> 1.5 -----> 1.6 -----> 1.7
                \               / \                          /
alan             \-> 1.2.1.1 --/---\-> 1.2.1.2 -> 1.2.1.3 --/


But from the Alan' branch, it looks like:


linus  1.1 -> 1.2 -> 1.2.1.1 -> 1.2.1.2 -> 1.2.1.3 -> 1.2.1.4 -> 1.2.1.5
                \               / \                              /
alan             \-> 1.3 ------/---\-----> 1.4 -----> 1.5 ------/


A virtual branch, used to track changesets, not per-file revisions, is
created in the parent repository during merge. At this time the merged
changesets receive new numbers appropriate for that branch. But since the
branch is only virtual, there is still only one line of development in the
repository. To see the changesets in the order they were applied, they must
be sorted not by revision number buy by merge time. Thus, with respect to
the above diagrams, the order in which the patches were applied, from Linus'
perspective, is:

1.1  1.2  1.3  1.2.1.1  1.4  1.5  1.6  1.2.1.2  1.2.1.3  1.7

                         Distributed Rename Handling

  1. Introduction

This consists of allowing developers to rename files and directories, and
have all repository operations properly recognize and handle this.

  2. Behavior

    2.1 Local

Renaming files and directories locally should preserve all historical
information including changeset tags.

    2.2 Distributed

In the general case, a single local repository attempts to merge
name-changes with a remote repository. In this case, the remote repository
receives the name change, along with all history including changeset tags.

      2.2.1 Conflicts

An arbitrary number of repositories cloned from either a single remote
repository or from each other may attempt to change the name of a single
file to arbitrary other names and then merge that change back to a single
remote repository or to each other.

An arbitrary number of repositories cloned from either a single remote
repository or from each other may rename file A to something else, and then
other files to the name formerly used by File A, or create a new file with
the name formerly used by file A; and then merge those changes to the single
remote repository or to each other.

An arbitrary number of repositories cloned from either a single remote
repository or from each other may attempt to create a file with the same
name and merge that change back to the remote repository or to each other.

                        Graphical 2- And 3-Way Merging Tool

  1. Introduction

Merge tools are tools used to resolve conflicts when merging files. See
tkdiff ( http://www.accurev.com/free/tkdiff/ )

  2. Behavior

The merge tools should identify precisely the areas of conflict, and enable
the user to quickly edit the files to resolve the conflicts and apply the
patch.

Merge tools must be able to handle patches as well as entire files.

A typical usage would be to pull all recent changes to a local tree from a
remote repository; then run the merge tools to resolve any conflicts between
the remote repository and changes that have been made locally; tag local
files to produce a changeset; and generate a diff for sharing.

               * * * Not Required For Kernel Development * * *

                                 Changesets

It should be possible to exchange changesets via email.

                                 File Types

The system should support symlinks, device special files, fifos, etc. (i.e.
inode metadata)




* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
This document is copyright Zack Brown and released under the terms of the
GNU General Public License, version 2.0.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

--------------------------------- cut here ---------------------------------


> 
> Regards,
> 
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zack Brown
