Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314393AbSEBNBk>; Thu, 2 May 2002 09:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314394AbSEBNBj>; Thu, 2 May 2002 09:01:39 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:8975 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S314393AbSEBNBj>; Thu, 2 May 2002 09:01:39 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.12 severe ext3 filesystem corruption warning!
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Thu, 02 May 2002 23:01:34 +1000
Message-ID: <87u1pqln4h.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave the 2.5.12 kernel a shot on my workstation tonight and found an
*extremely* serious ext3 filesystem corrupting behavior.

The only files that were mangled were files that had been modified while
running, so it looks like this is an issue with finding the contents of
modified files to write, not with random data dropping onto the disk.

That said, however, the contents were rather random -- blocks from
.overview were placed into a number of other files, chunks of
.newsrc.eld written to the gkrellm configuration file and the like.

Unmodified files, however, don't seem to have been touched. This can't
be perfect, of course, as something I never look at may have been
destroyed, but it seems to be reliably.

The system is a mobile P4, 512MB RAM, IDE disk. Only one filesystem
seems badly effected, my home directory, which is ext3 and fully
data-journaled.

I couldn't find corruption on the root filesystem[1] but there isn't
much of that which is actively written at runtime. Nothing notable in
/var seems broken, thankfully, so no panic. :)

Anyway, I don't know if anyone else is seeing the problems but this is a
first worrying datapoint with the kernel...

        Daniel

Footnotes: 
[1]  Contains everything else, including /usr and /var

-- 
20+ years as a vegetarian and the guy who steals my credit card
orders $6,000 worth of chicken parts: proof that the most powerful
force in the universe is Irony.
        -- David Weinberger, _JOHO_ (2000-03-20)
