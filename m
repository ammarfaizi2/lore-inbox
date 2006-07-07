Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWGGJi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWGGJi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWGGJi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:38:56 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:47561 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932085AbWGGJiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:38:55 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: ext4 features
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Bill Davidsen <davidsen@tmr.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 07 Jul 2006 11:38:01 +0200
References: <6tVcC-1e1-79@gated-at.bofh.it> <6uXYv-3RG-1@gated-at.bofh.it> <6veG8-350-7@gated-at.bofh.it> <6vfiU-465-13@gated-at.bofh.it> <6vmNk-77r-23@gated-at.bofh.it> <6vnq7-7Tw-55@gated-at.bofh.it> <6vrN0-5Se-9@gated-at.bofh.it> <6vBsY-38p-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1Fymn1-0000g6-7s@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Wed, 2006-07-05 at 22:32 -0400, Bill Davidsen wrote:

>> But with timestamps I need remember only one number, the time of my last
>> backup. Skipping over the question of "who's idea of time" inherent in
>> network filesystems. I compare all ctimes with the time of the last
>> backup and do incremental on the newer ones. If we use versioning I have
>> to remember the version for each file! In practice I really question if
>> the benefit justified keeping all that metadata between backups. And if
>> I delete a file and create another by the same name, what is it's version?
> 
> You are completely missing the point. Our background is that all NFS
> clients are required to use the mtime and ctime timestamps in order to
> figure out if their cached data is valid. They need to do this extremely
> frequently (in fact, every time you open() the file).

If the changes to these files are very infrequent compared to nanoseconds,
you'll only need the version during some nanoseconds, and only during
runtime. Having a second-change-within-one-timeframe-flag(*) instead of
versions will be enough to make NFS mostly happy and only penalize your
users for one nanosecond, and it won't force version-keeping into the
filesystem. And besides that, all other filesystems will profit even
without having nanosecond resolution nor versioning (but they'll suffer
for up to a whole second).


*) TODO: Create a nice name
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
