Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUBRChy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267181AbUBRChy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:37:54 -0500
Received: from hera.kernel.org ([63.209.29.2]:40327 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267170AbUBRChu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:37:50 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 02:37:22 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0uj52$3mg$1@terminus.zytor.com>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077071842 3793 63.209.29.3 (18 Feb 2004 02:37:22 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 02:37:22 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16434.41376.453823.260362@samba.org>
By author:    tridge@samba.org
In newsgroup: linux.dev.kernel
> 
>  > I don't know how Windows does it, so maybe this thing is hardcoded, and 
>  > you don't even want "true" case insensitivity. 
> 
> NTFS has a 128k table on disk, created at mkfs time and indexed by the
> UCS2 character.

So you're hosed if anyone uses characters outside the UCS-2 character
set...

> The interesting thing about this table is that it doesn't seem to
> vary between different locales as one might expect. I have checked 3
> locales so far (Swedish, Japanese and English) and all have the same
> 128k table. I should check a few more locales to see if it really is
> the same everywhere. Contact me off-list if you have a NTFS
> filesystem created in a different locale and would be willing to run
> a test program against it to see if the table is different from the
> one we have in Samba.

There is a "standard" table, which is published by the Unicode
consortium.  However, the "standard" table isn't what you want in
certain locales, e.g. Turkish.

> There is stuff in the charset handling of every locale that does vary
> in windows, but it isn't the case table, its the "valid characters"
> map used to determine what characters are allowed when converting
> strings into legacy multi-byte encodings. Even I don't think that the
> kernel will ever have to deal with that crap unless someone is foolish
> enough to port Samba into the kernel (several people have actually
> done that despite the insanity of the idea, but they all did an
> absolutely terrible job of it and certainly didn't take care to get
> all the charset handling right).
> 
> > How "correct" is Windows?
> 
> from my rather limited point of view I always have to assume that
> windows is "correct", unless I can show that its behaviour leads to
> data loss, a security hole or something equally extreme.

Well, we don't want to support a bunch of hacks to make it behave like
Windows if what Windows does doesn't make sense.  If so you should use
a metalayer where you canonicalize the filenames and don't store
"Makefile" on the disk; store "makefile" and keep the "real" filename
stashed elsewhere, perhaps an EA.

	-hpa

