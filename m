Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312311AbSDDM55>; Thu, 4 Apr 2002 07:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313164AbSDDM5w>; Thu, 4 Apr 2002 07:57:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:15633 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312311AbSDDM5g>; Thu, 4 Apr 2002 07:57:36 -0500
Message-ID: <3CAC3F42.4040100@evision-ventures.com>
Date: Thu, 04 Apr 2002 13:55:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1 fs/dquot
In-Reply-To: <Pine.LNX.4.33.0204031714080.12444-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking further through the pre patch I have found the following:

diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Wed Apr  3 17:11:14 2002
+++ b/fs/dquot.c	Wed Apr  3 17:11:14 2002
...
+static ctl_table fs_table[] = {
+ 
{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
+ 
  0444, NULL, &proc_dointvec},
+ 
{},
+};


What the heck is "dquot-nr"?

The breakup between the two abbreviations is not nice for the following reasons:

1. Invention of - is redundant becouse the whole thing is an abbreviation
    anyway.

2. It violates C/perl/whatever rules for item names.

3. The order of "nr" "preposition" and the "-" after the item is not consistant
    with the actual usage in application code!

The surrounding FS_NRDQUOT and nr_dquots show nicely that replacing
"dquot-nr" with "nrdquot" would fit much better and be much more consistant
with the implicite naming conventions used by programmers. Far easier
to grasp becouse there is no such thing as a disk quota of numbers...

Just nit-picking and ducking... ;-)

