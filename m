Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDUAyG>; Fri, 20 Apr 2001 20:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132385AbRDUAx4>; Fri, 20 Apr 2001 20:53:56 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:11026 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132392AbRDUAxr>;
	Fri, 20 Apr 2001 20:53:47 -0400
Date: Fri, 20 Apr 2001 20:52:46 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Proposal for better attribution structure
Message-ID: <20010420205246.A22693@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Andreas Dilger <adilger@turbolinux.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Matthew Wilcox <willy@ldl.fc.hp.com>,
	james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
	parisc-linux@parisc-linux.org
In-Reply-To: <20010420195004.A5510@flint.arm.linux.org.uk> <200104202123.f3KLNWSm031572@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104202123.f3KLNWSm031572@webber.adilger.int>; from adilger@turbolinux.com on Fri, Apr 20, 2001 at 03:23:32PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolinux.com>:
> One of the issues for contacting each MAINTAINER is that this information
> is out-of-line from the actual kernel tree.  The other is that the
> description of what a maintainer is actually controlling is somewhat
> vague.

I strongly agree.  I first tripped over this problem when I was trying
to identify the responsible parties for [Cc]onfig.in files.  It's
biting me again now that I'm trying to clean up the CONFIG_ space.
It's one that's going to cause grief for anybody trying to do *global*
work on the kernel, stuff that crosses boundaries between maintainer
jurisdictions.  
 
> How about the following:
> - each directory has a MAINTAINERS file which lists parties with a
>   vested interest in files in that directory (format is mostly the
>   same as current)
> - subdirectories which don't have a MAINTAINERS file use the MAINTAINERS
>   file of the parent (or grandparent) directory
> - each maintainer entry explicitly lists each file/directory that this
>   person is interested in, maybe "F: {file | directory} ...".
> 
> I'm sure Eric can come up with a simple program to parse the MAINTAINER
> file/tree.  If the program takes a kernel-tree relative filename and
> spit out the name/email of the relevant maintainer (subsystem and port
> specific mailing lists should also be included), that would make the 
> job of finding out who to send patches to a whole lot easier.

The spirit of this proposal is, IMO, excellent.  I like the idea that if
maintainer information for a particular piece of the hierarchy doesn't
exist, you float up to the next higher level.  Search always ends at
the root MAINTAINERS file.

And I could indeed write a program such as Andreas describes, and would
be most willing to do so.

I have one objection, however.  I think the maintainers information
should normally be inline of the file in question, so there won't
be a need for an explicit F: link that could become invalid.  So I
think the search order should look like this:

	1. Look for maintainer markup in the file itself.
	2. Then look for a NAINTAINERS file in the current directory.
	3. Then look upwards for MAINTAINERS files in enclosing directories.

> My one gripe about the MAINTAINERS file is that it still lists Remy
> Card as EXT2 maintainer, so we would probably need to do a find on
> the whole kernel tree, email each address a list of files that they
> "maintain" and wait until they complain, agree, or time out.  Once
> the database is up-to-date, it simplifies the job of keeping maintainers
> (and other interested parties) in the loop.

I have until 6 May at least to work on this, if there is consensus that it's
a good idea.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Where rights secured by the Constitution are involved, there can be no
rule making or legislation which would abrogate them.
        -- Miranda vs. Arizona, 384 US 436 p. 491
