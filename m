Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292733AbSBZTew>; Tue, 26 Feb 2002 14:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292749AbSBZTem>; Tue, 26 Feb 2002 14:34:42 -0500
Received: from ns.suse.de ([213.95.15.193]:41993 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292733AbSBZTeW>;
	Tue, 26 Feb 2002 14:34:22 -0500
Date: Tue, 26 Feb 2002 20:32:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Florian Lohoff <flo@rfc822.org>, linux-kernel@vger.kernel.org
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI Watchdog detected LOCKUP
Message-ID: <20020226203235.A4036@inspiron.school.suse.de>
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org> <3C7BDC57.A835D657@zip.com.au>, <3C7BDC57.A835D657@zip.com.au> <20020226191626.GA11283@paradigm.rfc822.org> <3C7BDFE6.313AA43D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BDFE6.313AA43D@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 11:20:06AM -0800, Andrew Morton wrote:
> Florian Lohoff wrote:
> > 
> > On Tue, Feb 26, 2002 at 11:04:55AM -0800, Andrew Morton wrote:
> > > > __block_prepare_write: zeroing uptodate buffer!
> > >
> > > Yup.   This happens when the disk fills up.  Andrea and I were
> > > discussing it over the weekend.   There's a new patch in the -aa
> > > kernels which doesn't quite fix it :(
> > >
> > > We'll fix it in 2.4.19-pre somehow.  It's possible that this problem
> > > causes a chnuk of zeroes to be written into the file when you hit
> > > ENOSPC, which is rather rude.  But your file was truncated anyway.
> > 
> > I dont think the machine had full filesystems at all.
> 
> I/O error when reading filesystem metadata would also cause it.

Indeed. Looks like gdth gone wild and that triggered the cleanup slowpath.

Andrea
