Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSEGXHt>; Tue, 7 May 2002 19:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315271AbSEGXHs>; Tue, 7 May 2002 19:07:48 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:35086 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315256AbSEGXHr>;
	Tue, 7 May 2002 19:07:47 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Wed, 8 May 2002 01:07:31 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Fwd: NLS mappings for iso-8859-* encodings
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <48A1C5128EB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 May 02 at 0:08, Urban Widmark wrote:
> On Tue, 7 May 2002, Petr Vandrovec wrote:
> 
> ncpfs should perhaps not use iso8859-x to read filenames in some cp*
> encoding. The default nls you can specify is strange, is it the default
> for chars on the filesystem or the default to use for display?
> 
> isofs uses it for display (and has no need for a second nls table).
> smbfs uses it for display and has a second default for the remote chars.
> ncpfs uses it as default for both display and remote.
> vfat also uses it for both on-disk and display.
> 
> I think ncpfs should demand that the user sets two defaults and if that
> isn't done no default translation is made (just do a memcpy in ncp__vol2io
> and ncp__io2vol). That's what smbfs does anyway.

Yes, it looks like a good idea.

> In unicode the 0x80-0x9F does not contain any printable characters, but
> they are defined. I know one table for iso8859-1 that lists that part as
> being empty/undefined, but it's not an iso document.
> 
> For someone setting their default to iso8859-1 that patch is probably ok,
> but what happens when someone sets it to a variable length encoding? (sjis)

They still have a problem - but they'll probably know what to do as they
had to change default NLS from iso8859-1 to something else.

> But if you have checked that you are not mapping two values to the same
> thing (which would break the back-and-forth translation that smbfs does) I
> don't see how that patch can harm anything.

Yes, I checked it. After changing iso* all singlebyte encodings except
cp874 contain unique mapping for all byte values (cp874 is unique, but
some values are unmappable).
                                    Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
