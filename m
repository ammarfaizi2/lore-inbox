Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbULIOIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbULIOIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbULIOIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:08:54 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:25556 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261347AbULIOHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:07:37 -0500
Date: Thu, 9 Dec 2004 15:07:25 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041209140725.GQ9994@fi.muni.cz>
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209135322.GK347@unthought.net>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
: > I have seen the strange problem on our NFS server: yesterday I have
: > found an empty file owned by UID 0/GID 0 and st_mode == 0 in my home
: > directory (ls -l said "?--------- 1 root root 0 <date> <filename>").
: > The <filename> was correct name of a temporary file used by one of my
: > cron jobs (and the cron job was failing because it could not rewrite the file).
: > It was not possible to write to this file, so I have renamed it
: > as "badfile" for further investigation (using mv(1) on the NFS server itself).
: 
: Known problem
: 
: http://lkml.org/lkml/2004/11/23/283
: 
: Seems there is no solution yet
: 
: http://lkml.org/lkml/2004/11/30/145
: 
	Hmm, thanks for the info.

	In the meantime, I was able to reproduce this by running the
following script for an hour or so on Solaris 8 NFS client:

#!/bin/bash
FILE="testfile"
set -e
while :
do
        rm -f "$FILE"
        sleep 1
        echo trubka > "$FILE"
        sleep 1
        cat "$FILE">/dev/null
done

After some time I've got this:

emptyfile.sh: testfile: Invalid argument
$ ls -l testfile
?---------   1 root     root           0 Dec  9 14:51 testfile

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
