Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRDUPt1>; Sat, 21 Apr 2001 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132717AbRDUPtI>; Sat, 21 Apr 2001 11:49:08 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:55826 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132710AbRDUPtC>;
	Sat, 21 Apr 2001 11:49:02 -0400
Date: Sat, 21 Apr 2001 11:49:42 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Request for comment -- a better attribution system
Message-ID: <20010421114942.A26415@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a proposal for an attribution metadata system in the Linux kernel 
sources.  The goal of the system is to make it easy for people reading
any given piece of code to identify the responsible maintainer.  The motivation
for this proposal is that the present system, a single top-level MAINTAINERS
file, doesn't seem to be scaling well.

In this system, most files will contain a "map block".  A map block is a
metadata section embedded in a comment near the beginning of the file.
Here is an example map block for my kxref.py tool:

# %Map
# T: CONFIG_ namespace cross-reference generator/analyzer
# P: Eric S. Raymond <esr@thyrsus.com>
# M: esr@thyrsus.com
# L: kbuild-devel@kbuild.sourceforge.net
# W: http://www.tuxedo.org/~esr/cml2
# D: Sat Apr 21 11:41:52 EDT 2001
# S: Maintained

And here's what a map block should look like in general:

%Map:
T: Description of this unit for map purposes
P: Person
M: Mail patches to
L: Mailing list that is relevant to this area
W: Web-page with status/info
C: Controlling configuration symbol
D: Date this meta-info was last updated
S: Status, one of the following:

	Supported:	Someone is actually paid to look after this.
	Maintained:	Someone actually looks after it.
	Odd Fixes:	It has a maintainer but they don't have time to do
			much other than throw the odd patch in. See below..
	Orphan:		No current maintainer [but maybe you could take the
			role as you write your new code].
	Obsolete:	Old code. Something tagged obsolete generally means
			it has been replaced by a better system and you
			should be using that.

There may be more than one P: field per map block.  There should be exactly one
M: field.

The D: field may have the special value `None' meaining that this map block
was translated from old information which has not yet been confirmed with the
responsible maintainer.

Note that this is the same set of conventions presently used in the
MAINTAINERS file, with only the T:, D:, and C: fields being new.  The
contents of the C: field, if present, should be the name of the
CONFIG_ symbol that controls the inclusion of this unit in a kernel.

(Map blocks are terminated by a blank line.)

Not every file need contain a map block.  To locate the responsible maintainer
for a file, use the following algorithm:

1. Look for a map block in the file itself.

2. Look for a file named %Map in the enclosing directory.
   Any map block in that file applies to the entire directory.

3. Look for a map block in the enclosing directory's README.
   Any map block in that file applies to the entire directory.

4. If you are at the root of the source tree, give up.
   Otherwise, move to the parent directory and goto step 2.

If this proposal meets with approval, I am willing to do three things:

1. Generate a patch to distribute the information presently in the
   MAINTAINERS file into map blocks and %Map files.

2. Write a tool for querying the map database.

3. (Background task, with which I would expect help) Chase down more
   map entries and verify information in old entries.

Thanks to Andreas Dilger for suggesting the basic idea.

Comments are solicited.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The day will come when the mystical generation of Jesus by the Supreme
Being as his father, in the womb of a virgin, will be classed with the
fable of the generation of Minerva in the brain of Jupiter.
	-- Thomas Jefferson, 1823
