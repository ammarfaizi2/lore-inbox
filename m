Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSBDS4U>; Mon, 4 Feb 2002 13:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSBDS4E>; Mon, 4 Feb 2002 13:56:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23557 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286179AbSBDSz5>;
	Mon, 4 Feb 2002 13:55:57 -0500
Date: Mon, 4 Feb 2002 18:55:55 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Joel Becker <jlbec@evilplan.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Steve Lord <lord@sgi.com>, Chris Wedgwood <cw@f00f.org>,
        Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020204185554.D2092@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
	Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
	Ricardo Galli <gallir@uib.es>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <1012835730.26397.519.camel@jen.americas.sgi.com> <E16XlK0-0007Wu-00@the-village.bc.nu> <20020204182942.C2092@parcelfarce.linux.theplanet.co.uk> <3C5ED7A6.C28407BA@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C5ED7A6.C28407BA@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 04, 2002 at 01:49:10PM -0500
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 01:49:10PM -0500, Jeff Garzik wrote:
> I have similar inclination, that is inspired from the implementation of
> "NTFS TNG": hard sector size should always equal sb->blocksize.  This
> allows for fine-grained operations at the O_DIRECT level, logical block
> sizes > PAGE_CACHE_SIZE, easy implementation of fragments (>= hard sect
> size), O_DIRECT for fragments, and other stuff.

	I'm not sure I get you here.  When I say hardsectsize, I mean
get_hardsectsize(dev), not super->s_blocksize.  On ext2, s_blocksize is
1k, 2k, or 4k.  Databases want to use O_DIRECT aligned at 512b.  This
can be done (again, see my patch), and I would think it necesary.
	If you meant that s_blocksize should match get_hardsectsize, I
agree.  If you meant the other way around, then consumers that want to
do O_DIRECT operations at 512b alingments won't be able to.

Joel

-- 

"All alone at the end of the evening
 When the bright lights have faded to blue.
 I was thinking about a woman who had loved me
 And I never knew"

			http://www.jlbec.org/
			jlbec@evilplan.org
