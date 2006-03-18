Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWCRMYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWCRMYX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCRMYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:24:23 -0500
Received: from thunk.org ([69.25.196.29]:21426 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751243AbWCRMYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:24:23 -0500
Date: Sat, 18 Mar 2006 07:24:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support 2^32-1blocks(e2fsprogs)
Message-ID: <20060318122419.GE21232@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	Badari Pulavarty <pbadari@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel <Ext2-devel@lists.sourceforge.net>
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp> <1142630359.15257.30.camel@dyn9047017100.beaverton.ibm.com> <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp> <20060318101102.GZ30801@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318101102.GZ30801@schatzie.adilger.int>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 03:11:02AM -0700, Andreas Dilger wrote:
> > As I said in my previous mail, You should specify -F option to
> > create ext2/3 which has more than 2**31-1 blocks.
> > It is because of the compatibility.
> 
> Oh, using -F for this is highly dangerous.  That would allow mke2fs to
> run on e.g. a mounted filesystem or something.  Instead use an option
> like "-E 16tb" or something.

Agreed that we shouldn't use -F, but what's the compatibility reason?
Supporting 2**31-1 blocks required bugfixes in the kernel and in
e2fsprogs, yes, but if it's not a filesystem format change, but rather
a "kernel had bugs which have now been fixed" statement, that's not
the sort of thing where I'd think forcing the system administrator to
add a magic command-line flag would be necessary or desirable.  

I could see printing a warning message saying that older kernels might
have problems with this, and I could also imagine including with the
kernel patch enabling some sort of flag that could be queried, perhaps
via /sys/fs/ext3/32bit-nr-blocks so that if it isn't present, mke2fs
could give a more emphatic warning that the current kernel wouldn't be
able to deal with filesystems being created.

					- Ted
