Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281012AbRKZFct>; Mon, 26 Nov 2001 00:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281144AbRKZFck>; Mon, 26 Nov 2001 00:32:40 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12037
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281012AbRKZFc2>; Mon, 26 Nov 2001 00:32:28 -0500
Date: Sun, 25 Nov 2001 21:30:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: To Journal or Not wrt cache.
Message-ID: <Pine.LNX.4.10.10111242121560.2927-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fact: Everything about Storage is a LIE, how to deal.

First there is an design flaw in Linux wrt to the theory of storage and
boundaries required to deal with the "Big Lie".  For all of those folks
that think SCSI is "The End All to be All", you need to think again.

Second, what is the BIG LIE all about?  
A HOST or DEVICE regardless of class will tell you only what it wants you
to know.  This is to be more clearly stated as : everything can do more
than it tells you but find out the full capablities is difficult and many
times protected in such a way to prevent one from find out.

The best example that I can give is from the storage side that I am
associated.  ATA/ATAPI devices have something called an "IDENTIFY" page,
which is specifically designed to provide the Host-OS-Driver a way to
classify the capablities and features of the device attached.  SCSI has a
similar method called a "MODE Page" or "Capabilities Struct".  Regardless
of the content of these points of information, they only tell you what the
device is "allowed" to perform for you.  This is completely different from
what the device is truly "capable" of doing.  Now in simpler terms this is
an effective "features mask".

Now did a "LIE" exist by accident, intention, neglect, etc in the past?
Who is to say, but you judge the following.

WRITE_VERIFY_READ
SET_FEATURES(updating if device self modifies)
        WRITE_CACHE(_EXT)
        FLUSH_CACHE(_EXT)

There was a concern the use of "WRITE_VERIFY_READ" was being abused to
artifically boost a devices actually throughput.  In the past it was not
clear that the contents issued by a "WRITE_VERIFY_READ" was read back from
the platters or out of dirty-cache (device buffer cache).  This has been
fixed as good as it gets now.  My vote was for a shall have come off the
media/platters during command execution.  This was modified to state it
had to have come off the platters but could have been read earlier.

Content updating for the "IDENTIFY Page" performed by a SET_FEATURES
command in the past may not have properly updated the contents to properly
reflect the current state of the features enabled/disabled by the
OS-driver or self modified by the device.  You should know that ATA/ATAPI
is/was not exclusive to this behavior.  SCSI will do the same, the
difference is that I can not find proper language to support that if a
SCSI device changes (self modifies) its "MODE Pages" or "Capabilities
Struct" it is required to update and report the changes.  If you are a
SCSI guru and can cite the T10 documents which reflect this ruleset, then
SCSI may be cleaner than suspected.  One is to never trust what is there
unless, that devices's transport layer rules published by NCITS/ANSI
clearly provides inforcement.

The others can be read about in the future release of ATA/ATAPI-6.

One of my first fears in the attempt to describe the needed solutions is I
will fail to translate the storage industry jargan to something
understandable, but here goes the announce of a potential white-paper.
 
*** FS/BLOCK/SPINDLE Storage model proposed, initial outline ***

Next Message to come.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project



