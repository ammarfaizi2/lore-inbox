Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291544AbSBAFIx>; Fri, 1 Feb 2002 00:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291545AbSBAFIo>; Fri, 1 Feb 2002 00:08:44 -0500
Received: from 2Cust41.tnt15.sfo3.da.uu.net ([67.218.141.41]:40462 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S291544AbSBAFId>;
	Fri, 1 Feb 2002 00:08:33 -0500
Date: Fri, 1 Feb 2002 00:14:57 -0800 (PST)
Message-Id: <200202010814.AAA25873@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: linux-kernel@vger.kernel.org
Subject: Tools, Not Penguins
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please CC me on replies.]

Rob Landley pointed out some problems with kernel development
and proposed solving the problem with a "patch penguin": a person
who would act as a sort of "integration manager" and "patch tracker"
for Linus, so that he might be able to handle a greater number of
incoming patches from a larger number of contributors.

If I'm understanding Linus' replies correctly, he doesn't want a
"star topology" of everyone in the world feeding him patches.
Instead, he wants (and more or less has) a graph of kernel hackers in
which a typical node has 10 or so edges, each edge connecting to a
trusted colleague, with patches flowing (almost) entirely along those
edges.  Nodes (hackers) are labeled with areas of specialization and
ideally those areas partition the kernel along the boundaries of
modularized components.

If Jane Q. Random wants to contribute a patch, and she isn't one
Linus' 10 friends, her best bet is to find a not-too-busy node,
labeled with the corresponding area of specialization, and hopefully
not too far from whatever tree maintainer (e.g. Linus) she wants to
ultimately receive the changes.  Hopefully she can find a node that
satisfies those constraints and that also has the property "works well
with Jane".

Another goal he's mentioned is that of keeping the flexibility of
dealing with raw patch sets.  For example, if one of the 10 adjacent
colleagues has 50 recent patches, Linus wants to be able to "cherry
pick" from those to get the 10 he's most confident about.  That
implies, for example, that whatever tools are used for patch
management should not impose artificial restrictions on the order in
which patches are applied.  Of the tools being discussed so far,
`diff and patch' do the best job of providing this flexibility.

I'd like to acknowledge another goal, hopefully without pissing off
Linus too much: there should be more than one tree, and more than one
tree maintainer.  In other words, the kernel *should* be forked (and,
in fact, as near as I can tell, *is* permanently forked already).
However, the important restriction is that while the kernel should be
forked, it shouldn't become fragmented.  In other words, the overall
graph of maintainers must *not* become partitioned into "maintainers
who send patches to tree A" and "maintainers who send patches to tree
B".  At every point in time, all of the trees should be able to pick
from more or less the same frontier of patches -- the differences
between forks being only differences of immediate goals, not long term
evolution.

Now, people have been griping about Linus not scaling, dropping
patches, etc.  And Linus has replied that the real problem is
contributors not working within the graph structure and not helping
the graph to grow larger.  That's a fair enough reply, but it doesn't
completely address the problems.  If you believe what you read in the
press or in the problem analysis that Rob wrote, the graph *is*
tending to become partitioned along tree-maintainer loyalties.  The
problem occurs when some maintainer gains enough trust from others
that people work with them to develop patches, but that maintainer
loses enough trust in Linus that the patches wind up going to some
other tree, nearly to the exclusion of Linus' tree.

The problem of the graph partitioning is partly a social problem,
but largely a technical problem.  It's an artifact of using `diff',
`patch', and email to implement patch flow along the graph.  The
diff/patch/email technique is inherently node-to-node and has a high
cost per exchange: someone sending out information about a patch has
to pick a specific audience for that information.  They have to pick a
specific tree against which to make diffs.  If an audience of multiple
recipients is coherent enough to act as one, fine -- the information
floods out on the graph as it should.  But if one part of the audience
is more responsive than the others, the less responsive part will tend
to be left behind.  The result is that instead of a P2P graph along
which good patches spread out, we get swift little rivers that
transport patches to some trees while leaving others high and dry, and
lots of distracting meta-data about which tree maintainers scale
better than others.

There is a tool that can help the graph run more smoothly and avoid
becoming fragmented: arch.  arch is a patch-management/revision
control system.  Much like using `diff/patch', arch is based on the
idea that programmers should coordinate their trees by exchanging
patch sets.  arch is very flexible about letting programmers pick
and choose from the available patches (it supports "cherry picking").  
arch gives you access to past revisions as a "forest of trees",
therefore you can combine the use of arch with the use of other
tools like `diff', `patch', `grep', `find', etc.

Like a good revision control system, arch let's you manage trees
using concepts like "branching" and "merging".   It keeps extensive
history about what has been merged with what and has a browser for
studying the patch application history of any particular tree.  See,
for example, the "cataloged configurations" links at:

    http://www.regexps.com/{browser}

arch doesn't require everyone to use a central patch-set repository.
Instead, every (major) node on the graph can have their own
repositories, on their own site -- arch seamlessly operates across
repository boundaries.

arch has the potential to solve the technical component of the graph
partitioning problem.  Instead of a graph node narrow-casting
information about patches to specific adjacent nodes, each node can
use arch to expose a library of all patches available at that node
-- essentially broadcasting them to all adjacent nodes equally.  Sure,
you'll still want meta-data in email ("you should consider patch-120
in the IDE tree") but those exchanges can be much less costly if they
just refer to data available via, for example, the arch browser.
arch makes it relatively easy to take a patch set prepared against
one tree, and either apply it as-is to some other tree, or use it to
derive a second patch set prepared against that other tree.

arch can also simplify the problem of keeping a patch up-to-date
with respect this or that tree while it is waiting to be applied to
that tree: arch has a CVS-like `update' command, but it also has
more flexible variations like `replay' and `star-merge'.  There's no
restriction that the node that "owns" the patch has to do this work --
another nice side effect of archs seamless operation across
repository boundaries.

arch is available at http://www.regexps.com

The biggest technical obstacle to deploying arch for kernel
work today is that arch is fairly new, with all that that implies.

-t
