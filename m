Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTJQJsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTJQJsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:48:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:54999 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263361AbTJQJsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:48:15 -0400
Message-ID: <3F8FBADE.7020107@namesys.com>
Date: Fri, 17 Oct 2003 13:48:14 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norman Diamond <ndiamond@wta.att.ne.jp>
CC: Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors
 numbered strangely, and what happens to them?)
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
In-Reply-To: <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:

>Friends in the disk drive section at Toshiba said this:
>
>When a drive tries to read a block, if it detects errors, it retries up to
>255 times.  If a retry succeeds then the block gets reallocated.  IF 255
>RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
>
>This was so unbelievable to that I had to confirm this with them in
>different words.  In case of a temporary error, the drive provides the
>recovered data as the result of the read operation and the drive writes the
>data to a reallocated sector.  In case of a permanent error, the block is
>assumed bad, and of course the data are lost.  Since the data are assumed
>lost, the drive keeps the defective LBA sector number associated with the
>same defective physical block and it does not reallocate the defective
>block.
>
>I explained to them why the LBA sector number should still get reallocated
>even though the data are lost.  When the sector isn't reallocated, I could
>repartition the drive and reformat the partition and the OS wouldn't know
>about the defective block so the OS would try again to use it.  At first
>they did not believe I could do this, but I explained to them that I'm still
>able to delete partitions and create new partitions etc., and then they
>understood.
>
>They also said that a write operation has a chance of getting the bad block
>reallocated.  The conditions for reallocation on write are similar but not
>identical to the conditions for reallocate on read.  During a write
>operation if a sector is determined to be permanently bad (255 failing
>retries) then it is likely to be reallocated, unlike a read.  But I'm not
>sure if this is guaranteed or not.  We agreed that we should try it on my
>bad sector, but if the drive again detects a permantent error then it will
>not reallocate the sector.  First I still want to find which file contains
>the sector; I haven't had time for this on weekdays.
>
>When I ran the "long" S.M.A.R.T. self-test, the number of reallocated
>sectors and number of reallocation events both increased from 1 to 2, but
>the known bad sector remained bad.  This is entirely because of the behavior
>as designed.  The self-test detected a temporary error in some other
>unrelated sector, rescued the data in that unreported sector number, and
>reallocated it.  That was only a coincidence.  The known bad sector was
>detected yet again as permanently bad and was not reallocated.
>
>In this mailing list there has been some discussion of whether file systems
>should keep lists of known bad blocks and hide those bad blocks from
>ordinary operations in ordinary usage.  Of course historically this was
>always necessary.  As someone else mentioned, and I've done it too, when
>formatting a disk drive, type in the list of known bad block numbers that
>were printed on a piece of paper that came with the drive.
>
>In modern times, some people think that this shouldn't be necessary because
>the drive already does its best to reallocate bad blocks.  WRONG.  THE BAD
>BLOCK LIST REMAINS AS NECESSARY AS IT ALWAYS WAS.
>
>This design might change in the future, but it might not.  My friends are
>afraid that they might lose their jobs if they try to suggest such a change
>in the high-level design of disk drive corporate politics.  I only hope this
>posting doesn't get them fired.  (This is not a frivolous concern by the
>way.  The myth of lifetime employment is a less pervasive myth than it used
>to be, and Toshiba is pretty much average in both world and Japanese
>standards for corporate politics.)
>
>Regarding finding which file contains the known bad sector, someone in this
>mailing list said that the badblocks program could help, but the manual page
>for the badblocks program doesn't give any clues as to how it would help.
>I'm still doing find of all files in the partition and cp them to /dev/null.
>
>Meanwhile, yes we do need to record those bad block lists and try to never
>let them get allocated to user-visible files.
>
>
>
>  
>
Instead of recording the bad blocks, just write to them.

-- 
Hans


