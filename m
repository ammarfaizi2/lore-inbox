Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267919AbTBELVQ>; Wed, 5 Feb 2003 06:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267920AbTBELVQ>; Wed, 5 Feb 2003 06:21:16 -0500
Received: from daimi.au.dk ([130.225.16.1]:5049 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267919AbTBELVP>;
	Wed, 5 Feb 2003 06:21:15 -0500
Message-ID: <3E40F5DC.275FFE9D@daimi.au.dk>
Date: Wed, 05 Feb 2003 12:30:36 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: isofs hardlink bug (inode numbers different)
References: <20030126235556.GA5560@paradise.net.nz> <b1nd5m$rhp$1@cesium.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> There are inode numbers stored in RockRidge attributes, but using them
> comes with some humongous caveats:
> 
> First: You have absolutely no guarantee that they are actually
> unique.  Broken software could easily have written them with all
> zeroes.

Maybe we can detect some of the cases with broken software, and
at least provide an option to turn the RockRidge inode numbers
off.

> 
> Second: If there are files on the CD-ROM *without* RockRidge
> attributes, you can get collisions with the synthesized inode numbers
> for non-RR files.

That can easily be solved. RockRidge inode numbers are multiplied
by two, and synthesized inode numbers are all odd. Of course if
the multiplication overflows a fallback to synthesized inode
numbers would be necesarry. Does any software produce inode
numbers large enough to make this a problem?

> 
> Third: If you actually rely on inode numbers to be able to find your
> files, like most versions of Unix including old (but not current)
> versions of Linux, then they are completely meaningless.

Agreed.

> 
> There is another way to generate consistent inodes for hard links,
> which is to use the data block pointer as the "inode number."  This,
> however, has the problem that *ALL* zero-lenght files become "hard
> links" to each other.

That problem can easily be solved. Simply use different methods
for zero-length files and all other files. But there might be
other problems with such an approach:

1) Could two different files have same data block pointer?
   (different sizes perhaps?)
2) Do we need a way to find metadata from the inode number?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
