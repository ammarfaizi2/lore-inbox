Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSEGWJc>; Tue, 7 May 2002 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSEGWJb>; Tue, 7 May 2002 18:09:31 -0400
Received: from fungus.teststation.com ([212.32.186.211]:59657 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314458AbSEGWJa>; Tue, 7 May 2002 18:09:30 -0400
Date: Wed, 8 May 2002 00:08:51 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: NLS mappings for iso-8859-* encodings
In-Reply-To: <20020507161357.GC15298@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0205072342570.10866-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Petr Vandrovec wrote:

>   If I'll not receive any feedback, I plan to send it to Linus soon.
> Currently if you'll mount NCP filesystem with accented characters
> without proper iocharset/codepage options, you'll not see filenames
> with accented characters at all, as they will not pass through
> char2uni of default (iso8859-1) NLS (there was warning printk,
> but it was way to DoS...).

ncpfs should perhaps not use iso8859-x to read filenames in some cp*
encoding. The default nls you can specify is strange, is it the default
for chars on the filesystem or the default to use for display?

isofs uses it for display (and has no need for a second nls table).
smbfs uses it for display and has a second default for the remote chars.
ncpfs uses it as default for both display and remote.
vfat also uses it for both on-disk and display.

I think ncpfs should demand that the user sets two defaults and if that
isn't done no default translation is made (just do a memcpy in ncp__vol2io
and ncp__io2vol). That's what smbfs does anyway.


In unicode the 0x80-0x9F does not contain any printable characters, but
they are defined. I know one table for iso8859-1 that lists that part as
being empty/undefined, but it's not an iso document.

For someone setting their default to iso8859-1 that patch is probably ok,
but what happens when someone sets it to a variable length encoding? (sjis)


The other definition is that the linux side is always utf8 and that the
default therefore must be what the other end writes. I still haven't seen
any setup where (eg) X is configured to do that (with fonts and all) but
it was stated as the official encoding by a bearded senior member of this
list.


But if you have checked that you are not mapping two values to the same
thing (which would break the back-and-forth translation that smbfs does) I
don't see how that patch can harm anything.

/Urban

