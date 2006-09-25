Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWIYA2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWIYA2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWIYA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:28:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62128 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751554AbWIYA2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:28:09 -0400
Message-ID: <45172297.6070108@garzik.org>
Date: Sun, 24 Sep 2006 20:28:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] add and use include/linux/magic.h
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090408090504060204070703"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408090504060204070703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Sun, 24 Sep 2006, Jeff Garzik wrote:
>> Along the lines of linux/poison.h, do a similar thing with filesystem
>> superblock (and later perhaps, other) magic numbers.  This permits
>> us to delete several headers which -only- included the superblock
>> magic number, and it integrates well with dwmw2's header_check /
>> header_install stuff.
> 
> Ok, I'm a little worried that somebody might want its own magic number, 
> but not have its namespace poisoned by other peoples magic numbers (think 
> some user-level program like "e2fsck"), but I guess it's unlikely to be a 
> real problem.

Yeah, especially given that the namespace has separate prefixed for 
separate filesystems.


> One more thing: your "please pull" looks fine, but if you were to also add 
> the "--summary" argument to the diffstat generation, I'd have seen:
> 
>> Please pull from 'magic' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git magic
>>
>> to receive the following updates:
>>
>>  fs/affs/affs.h               |    1 -
>>  fs/affs/super.c              |    1 +
>> ....
>>  include/linux/smb.h          |    3 +--
>>  include/linux/usbdevice_fs.h |    3 +--
>>  30 files changed, 67 insertions(+), 85 deletions(-)
> 
> followed by:
> 
>  delete mode 100644 include/linux/affs_fs.h
>  delete mode 100644 include/linux/hpfs_fs.h
>  create mode 100644 include/linux/magic.h
>  delete mode 100644 include/linux/openprom_fs.h
> 
> which is nice. You see which files actually disappear or appear (or are 
> renamed). Ok?

Right now I just pipe 'git diff master..branch' to diffstat.

I've attached the script I use, it's pretty basic.

Since I'm using the normal diffstat, "just add --summary" won't work. 
What is the full command line you were looking for?

	Jeff



--------------090408090504060204070703
Content-Type: text/plain;
 name="mkmsg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mkmsg"

#!/bin/sh

BRANCH="$1"
TEXT_OUT="$2"

PWD=`pwd`
REPO=`basename $PWD`

echo "Please pull from '$BRANCH' branch of" > $TEXT_OUT
echo "master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/$REPO.git $BRANCH" \
	>> $TEXT_OUT
echo "" >> $TEXT_OUT
echo "to receive the following updates:" >> $TEXT_OUT
echo "" >> $TEXT_OUT

git diff master..$BRANCH | diffstat -p1 >> $TEXT_OUT
echo "" >> $TEXT_OUT
git log --no-merges master..$BRANCH | git shortlog >> $TEXT_OUT
git diff master..$BRANCH >> $TEXT_OUT


--------------090408090504060204070703--
