Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271085AbRHOIWQ>; Wed, 15 Aug 2001 04:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271086AbRHOIWH>; Wed, 15 Aug 2001 04:22:07 -0400
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.102.89.11]:48628 "HELO
	scotch.homeip.net") by vger.kernel.org with SMTP id <S271085AbRHOIVy>;
	Wed, 15 Aug 2001 04:21:54 -0400
Date: Wed, 15 Aug 2001 04:22:05 -0400 (EDT)
From: God <atm@sdk.ca>
To: linux-kernel@vger.kernel.org
Subject: [BUG?] :: "Value too large for defined data type"
Message-ID: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

In short, I may have done a bad thing, this I know but .....

I noticed that when I tried to backup a box across the LAN via dump to a
localy mounted drive ...

<mental picture>
Box1 has:
hda and hdb, hdb has a fat32 fs (don't ask)

Box2 has 
/mnt/backup, mounted to box2:/mnt/hdb1.  

</mental picture>

.. dump crashed with:

  DUMP: 78.80% done at 814 kB/s, finished in 0:10
  DUMP: error reading command pipe in master: No such file or directory
  DUMP: The ENTIRE dump is aborted.


Trying to check where dump should have written the file on box2, I get:

# ls -al
/bin/ls: test: Value too large for defined data type
total 2097216
drwxrwxrwx   2 root     root        32768 Aug 14 23:27 ./
drwxrwxrwx  50 root     root        32768 Aug 14 21:02 ../
-rwxrwxrwx   1 root     root     2147483647 Aug 14 22:11
box1.071401.dump*
#


Ok so I lied, that is a paste from after my little expriment, but you can
see the file size.  2.1G, out of a 3G drive.


What caused the error and my emailing the list, is I created a file using
dd (dd if=/dev/zero of=test bs=4098k count=1000), but I cannot access that
file at all.  The only thing that seems to not care about it is "echo" :

# echo *
box1.071401.dump test
#

I tried to remove the file using rm, but I get the same error as ls:

# rm test
rm: cannot remove `test': Value too large for defined data type
# 

The file is taking up ~4G of space (which is reflected correctly with df,
du will not read the file).  

It was a stupid thing to do, but could there be a better way for the OS to
handle this and is there any way I can remove the file?  It's on  a 60
Gig drive, so formatting would not be an option right about now ...

The box in question (box2), is running Slack with a 2.4.3 kernel:

# uname -a
Linux box2 2.4.3 #7 SMP Sun Apr 29 13:42:05 EDT 2001 i686 unknown
#


Any thoughts?  




