Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289730AbSAOXG1>; Tue, 15 Jan 2002 18:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289824AbSAOXGS>; Tue, 15 Jan 2002 18:06:18 -0500
Received: from [66.89.142.2] ([66.89.142.2]:2621 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S289730AbSAOXGE>;
	Tue, 15 Jan 2002 18:06:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: initramfs buffer spec -- second draft
Date: Wed, 16 Jan 2002 00:09:10 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <20020115140436.L11251@lynx.adilger.int>
In-Reply-To: <20020115140436.L11251@lynx.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Qcha-0001lF-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 10:04 pm, Andreas Dilger wrote:
> On Jan 15, 2002  21:16 +0100, Daniel Phillips wrote:
> > On January 15, 2002 09:03 pm, H. Peter Anvin wrote:
> > > Daniel Phillips wrote:
> > > > Encoding the numeric fields in ASCII/hex is a goofy wart on an otherwise
> > > > nice  design.  What is the compelling reason?  Bytesex isn't it: we
> > > > should just pick one or the other and stick with it as we do in Ext2.
> > > > 
> > > > Why don't we fix cpio to write a consistent bytesex?
> > > 
> > > Because we want to use existing tools.
> > 
> > It's a mistake not to fix this tool.  I'll post the cost in terms of bytes
> > wasted shortly, pretty tough to argue with that, right?
> 
> Well, I doubt the difference will be more than a few bytes, if you compare
> the cpio archive sizes after compression with gzip.

Coming soon...

Side note: I have a hard time understanding the dual thinking that goes
something like: "we have to save every nanosecond of CPU but wasting disk is
ok because, um, disk is cheap, and everybody has more than they need anyway,
and reading it takes zero time and oh yes, everybody has disks, don't they?"

> > > I don't think think this application alone is enough to add Yet Another 
> > > Version of CPIO.  However, if there are more compelling reasons to do so 
> > >   for CPIO backup reasons itself I guess we could write it up and add it 
> > > to GNU cpio as "linux" format...
> > 
> > Oh, it is, really it is.  It's not just any application, and GNU already
> > has its own verion of cpio.
> 
> But then every person who wants to build a kernel will have to have
> the patched version of cpio until such a time it is part of the standard
> cpio tool...

If we go with little-endian then only big-endian architectures will need
the patch, and they tend to need patches for lots of things anyway.  Or
if you like I'll write a little utility that goes through the file and
byteswaps all the int fields.

> (which may be "never").  I would much rather use the currently
> available tools than save 20 bytes off a 900kB kernel image.

What if it's more than 20 bytes?

--
Daniel
