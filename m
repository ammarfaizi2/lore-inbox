Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286973AbRL1Sfq>; Fri, 28 Dec 2001 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286971AbRL1Sf1>; Fri, 28 Dec 2001 13:35:27 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:26980 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S286980AbRL1SfY>; Fri, 28 Dec 2001 13:35:24 -0500
Posted-Date: Fri, 28 Dec 2001 18:34:17 GMT
Date: Fri, 28 Dec 2001 18:34:16 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <20011227163130.N12868@lynx.no>
Message-ID: <Pine.LNX.4.21.0112281810330.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas.

>> Someone (Alan?) suggested having something like a web interface
>> allowing anyone interested in any particular file to register their
>> interest, and get added to the cclist for that file. Which is also
>> a cool idea.

> Well, in the past I had suggested to ESR (and he agreed) that it
> would be nice to split up the MAINTAINERS file (and maybe even
> Configure.help) to be more heirarchical in nature, so that there
> would be a MAINTAINER file in each directory, and maybe even
> MAINTAINER.<file> for files in common directories like
> drivers/net/foo.c. In the top-level MAINTAINER file would only be
> something like "Marcello Tosatti" to cover the entire tree, and e.g.
> "David Miller" in the net/MAINTAINER, "Al Viro" in the
> fs/MAINTAINER, "Stephen Tweedie" in fs/ext3/MAINTAINER, etc.

Can I suggest an alternative: Retain the MAINTAINERS file as it
currently is, but add a PATCHES-TO file in each subdirectory that
states how to handle patches relating to that directory, and have
these files follow a strict format, possibly...

===8<=== CUT ===>8===

HomeDir = linux/subsystem/
List = subsystem@server.site
Maintainer = Guess Who <uessWho@hear.thou.me>
Watch * = Interested <interested@private.site>
Watch PATCHES-TO = John Doa <administrator@linux.org>

===8<=== CUT ===>8===

...where the lines are as follows...

	HOMEDIR = relative-path

		The directory in the tree that this PATCHES-TO
		file belongs in. Must occur exactly once, and
		must start with linux/ to indicate the base
		directory this tree has been installed in.

	LIST = mailing-list-email-address

		A mailing list dealing with this part of the
		kernel tree. Can be repeated if multiple lists
		need to be specified, or omitted if there is no
		specific mailing list for this subsystem.

	NEWS = newsgroup

		A newsgroup dealing with this part of the kernel
		tree. Can be repeated if multiple newsgroups need
		to be specified, or omitted if no newsgroups are
		relevant to this section of the tree.

	MAINTAINER = name <email-address>

		The name and email address of the primary maintainer
		for files in this directory. Can be repeated if
		multiple maintainers need to be specified. Must
		occur in the file in the base directory, but can
		be omitted in any subdirectory in which case it
		indicates that the maintainer of the parent also
		maintains this subdirectory.

	WATCH filespec = name <email-address>

		Specifies that the email address specified is also
		interested in patches relating to the specified
		files, and should be CC'd patches relating to just
		the files specified. Files of interest are selected
		using ls style wildcards. Can be repeated as often
		as required for either the same or different files.
		The filespec can not contain / characters, and only
		matches files in the current directory.

...and all unrecognised lines are taken to be valid comments and are
ignored by all tools.

Comments?

Best wishes from Riley.

