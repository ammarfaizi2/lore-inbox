Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129714AbRBVXIs>; Thu, 22 Feb 2001 18:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbRBVXIj>; Thu, 22 Feb 2001 18:08:39 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:35533 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S129250AbRBVXIY>; Thu, 22 Feb 2001 18:08:24 -0500
Message-ID: <3A959BFD.B18F833@netcomuk.co.uk>
Date: Thu, 22 Feb 2001 23:08:45 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Subject: Hashing and directories
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I was hoping to point out that in real life, most systems that
need to access large numbers of files are already designed to do
some kind of hashing, or at least to divide-and-conquer by using
multi-level directory structures.

 A particular reason for this, apart from filesystem efficiency,
is to make it easier for people to find things, as it is usually
easier to spot what you want amongst a hundred things than among
a thousand or ten thousand.

 A couple of practical examples from work here at Netcom UK (now
Ebone :), would be say DNS zone files or user authentication data.
We use Solaris and NFS a lot, too, so large directories are a bad
thing in general for us, so we tend to subdivide things using a
very simple scheme: taking the first letter and then sometimes
the second letter or a pair of letters from the filename.  This
actually works extremely well in practice, and as mentioned above
provides some positive side-effects.

 So I don't think it would actually be sensible to encourage
anyone to use massive directories for too many tasks.  It has a
fairly unfortunate impact on applying human intervention to a
broken system, for example, if it takes a long time to find a
file you're looking for.

 I guess what I really mean is that I think Linus' strategy of
generally optimizing for the "usual case" is a good thing.  It
is actually quite annoying in general to have that many files in
a single directory (think \winnt\... here).  So maybe it would
be better to focus on the normal situation of, say, a few hundred
files in a directory rather than thousands ...

 I still think it's a good idea to do anything you can to speed
up large directory operations on ext2 though :)

 On the plus side, hashes or anything resembling tree structures
would tend to improve the characteristics of insertion and removal
of entries on even moderately sized directories, which would
probably provide a net gain for many folks.

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
