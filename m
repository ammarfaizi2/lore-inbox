Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUHCSeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUHCSeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUHCSeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:34:07 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:43921 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S266805AbUHCSdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:33:45 -0400
Message-ID: <410FDA19.9020805@tlinx.org>
Date: Tue, 03 Aug 2004 11:31:53 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org> <20040729013049.GE800@frodo>
In-Reply-To: <20040729013049.GE800@frodo>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-28-04 Nathan Scott blissfully wrote:

>On Fri, Jul 09, 2004 at 09:37:48AM -0700, L A Walsh wrote:
>
>>It's a feature! :-)
>>It's been in the code for years to randomly write nulls to some files 
>>
>Pfft, nonsense. 
>
The above was meant somewhat tongue-in-cheek, ya know...

> The problem relates to an updated inode size
>being flushed ahead of the data behind it (hence a size update
>can make it out before delayed allocate extents do, and we end
>up with a hole beyond the end of file, which reads as zeroes).
>
I believe I understand the scenario you are talking about, but I don't
think it fits the examples I have referred to.  In particular, "/etc/fstab".
I update 'fstab' on Tuesday, say, it works fine...gets backed up just
fine...and I forget about it and move on.  Then, 2-3 days later, my
system crashes and doesn't want to some up.  That's odd, usually after
a crash, it just burps a bit and comes back up.  I grumble and go for
single user.  Turns out my 1.2k fstab file is all "nulls".  Coinidentally,
I find, _maybe_, a couple of other files written around the same time,
also nulled, including times when the nulls appeared in the system log
for that time period! 

Now I know it takes a while before data may end up on disk and that it
may not go out to disk in an ordered fashion, but 2-3 days?  This isn't
a case of a multi-extent file.  My current fstab is only 1335 bytes long.
I doubt it has ever been more than 2.  

My filesystems all use the Allocation unit (AU) size allowed.  I wish
for something larger than a 4k AU size but I'm told it is limited by
the linux page size and to find a PC that uses the IA64 page size to
use larger file AU size (but I haven't seen to many of these IA64 machines
available from Dell or Gateway...:-)  Maybe the code in FAT32 that handles
larger AU's could be ported to XFS?  If FAT32 can do it...nevermind...
I'm sure there are more important issues on the plate.

>>Apparently not easily reproduced, no one has a clue why it does it.  
>>Just does. 
>>
>No, its actually well known why it behaves this way.
>We are looking into ways to address this, and have some
>ideas - the trick is fixing it without hurting write
>performance - which we will do, its just not trivial.
>
You could increase the max AU size :-)  But more seriously, is my
example of writing a 1 AU sized file that becomes zeroed days later
an example of the problem you are speaking of?

>There are several techiques to reduce the impact of this
>behaviour, as others have described (or see the linux-xfs
>archives).
>
Like setting the disk for synchronous writes?  Why not something
in between, like guaranteeing the info on a mostly quiescent machine
will be written to disk within an hour or so?  Or is that not "it"?

I haven't seen an incidence of this behavior in several months on
my machines so my particular problem may have been fixed and the
problem you speak of is unrelated to my own, but the number of unplanned 
shutdowns on my system has only increased recently, since I upgraded
to the stable 2.6 series, whereas before, with 2.4, it could be months
between "blue screens".

Sad was the day that it was decided that the linux-kernel "corp" decided
on feature development vs. stability in the "stable" kernel series. 
Isn't that criticism lodged most often against MS. It seems most 
"companies",
incorporated or not, seem to follow similar growth patterns.  Wasn't
there an Eastern saying about choosing your enemies wisely for you
will eventually become like them?

-l

