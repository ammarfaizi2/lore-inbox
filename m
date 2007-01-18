Return-Path: <linux-kernel-owner+w=401wt.eu-S1751798AbXAUXuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXAUXuw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXAUXuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:50:51 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:45914 "EHLO
	relay02.mail-hub.dodo.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751798AbXAUXuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:50:50 -0500
X-Greylist: delayed 51875 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 18:50:49 EST
From: Grant Coady <grant_lkml@dodo.com.au>
To: Willy Tarreau <w@1wt.eu>
Cc: Grant Coady <gcoady.lk@gmail.com>,
       Santiago Garcia Mantinan <manty@debian.org>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org,
       dannf@dannf.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Date: Thu, 18 Jan 2007 16:59:24 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <po0uq29lb4fk9pepuh67d4dlmsfc3koshe@4ax.com>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <4pctq2tqjnoap3khma0496h2fhfpg1rs75@4ax.com> <20070118042116.GA11914@1wt.eu>
In-Reply-To: <20070118042116.GA11914@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007 05:21:16 +0100, Willy Tarreau <w@1wt.eu> wrote:

>Hi Grant !
>
>On Thu, Jan 18, 2007 at 11:09:57AM +1100, Grant Coady wrote:
>(...)
>> > 	} else {
>> >-		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
>> >-						S_IROTH | S_IXOTH | S_IFREG;
>> >-		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
>> >-						S_IROTH | S_IXOTH | S_IFDIR;
>> >+		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
>> >+				S_IROTH | S_IXOTH | S_IFREG | S_IFLNK;
>> >+		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
>> >+				S_IROTH | S_IXOTH | S_IFDIR;
>> > 		if (parse_options(mnt, raw_data))
>> > 			goto out_bad_option;
>> 
>> I'm comparing 2.4.33.3 with 2.4.34, with 2.4.34 and above patch symlinks 
>> to directories seen as target, nor can they be created (Operation not 
>> permitted...)
>
>Thanks very much Grant for the test. Could you try a symlink to a file ?

"Operation not permitted"

>And while we're at it, would you like to try to add "|S_IFLNK" to
>mnt->dir_mode ? If my suggestion was stupid, at least let's test it to
>full extent ;-)

Yep, already tried the obvious ;)  no difference :(

2.4.33.5 onwards also have a problem with symlinks, but it is slightly 
different presentation, the directory symlinks appear as normal files.

With 2.4.33.7 one is able to create file and directory symlinks, though 
the links appear as files.  Content problem as noted by OP:

grant@sempro:/home/other$ uname -r
2.4.33.7
grant@sempro:/home/other$ cat file
this is a test
grant@sempro:/home/other$ cat filelink
thisgrant@sempro:/home/other$

grant@sempro:/home/other$ mkdir directory
grant@sempro:/home/other$ ln -s directory directorylink
grant@sempro:/home/other$ cp file* directory
grant@sempro:/home/other$ ls directory
file*  filelink*
grant@sempro:/home/other$ ls directorylink
directorylink*

Now, WinXP sees the contents of directorylink:

X:\>cd directorylink

X:\directorylink>dir
 Volume in drive X is other
 Volume Serial Number is 107E-052F

 Directory of X:\directorylink

2007-01-18  16:36    <DIR>          .
2007-01-18  16:33    <DIR>          ..
2007-01-18  16:36                15 file
2007-01-18  16:36                 4 filelink
               2 File(s)             19 bytes
               2 Dir(s)   2,558,922,752 bytes free

X:\directorylink>type file
this is a test

X:\directorylink>type filelink
this
X:\directorylink>
>
>I had another idea looking at the code but since I really don't know it,
>I would not like to propose random changes till this magically works. I'd
>wait for Dann who understood the code.

Grant.
