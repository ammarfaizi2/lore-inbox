Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269265AbTCBSSs>; Sun, 2 Mar 2003 13:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269267AbTCBSSs>; Sun, 2 Mar 2003 13:18:48 -0500
Received: from nils.bezeqint.net ([192.115.106.38]:41128 "EHLO
	nils.bezeqint.net") by vger.kernel.org with ESMTP
	id <S269265AbTCBSSn>; Sun, 2 Mar 2003 13:18:43 -0500
From: "Elie" <welie@bezeqint.net>
To: <linux-kernel@vger.kernel.org>
Subject: cp -a hangs (wait_on_buffer)
Date: Sun, 2 Mar 2003 20:28:52 +0200
Message-ID: <JLEOIKOLJCFPEIJOOOECGEHACEAA.welie@bezeqint.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Model Maxtor 13 gig 93160U4

I am having problems transfering my file system from disk 1 (hdb) to
disk 2 (hdc). cp -a hangs under apparently random conditions. A look
at ps shows that cp in waiting_on_buffer and other processes such as
kupdated are also waiting for data. The hard drive light stays on and,
obviously, any other commands issued after that, that need to write to
hdc hang. The rest of the system runs fine. I am using redhat 8.0, I
did not install the recent kernel update though it doesn't seem to
affect me (even though it is an update for ext3). The 

I am not a newbie but I am not an advanced user so please have
patience.

The big issue here may be that this drive was originaly from an iMac.
It is a 13gig ide drive from Maxtor. According to the maxtor site,
there is no indication that this drive is specail for Mac's, however
there is some mac stuff labled on the outside of the HD. This drive
has worked fine until now and I recently plugged it into to a Mac G4
to back up the data.

I'm not including the output of ps for now since this may just be a
bad hardware error. Let me know if I need to.

Ok, here is the entire process.
Disk 1: 4 linux ext3 partitions on hdb. (3 to be copied to disk2)
Disk2: The old imac drive. Repartioned the drive into 3 partitions and
formated to ext3. It is hdc, there is nothing else on the 2nd ide line
now.

3 disk2 partitons mounted under /new-disk (following example of har
drive upgrade mini how to). Partitions mount fine, fsck shows no
problems.

I start to cp -a / /new-disk/home and cp hangs (note I leave out
several dir's using command line I don't remember). Ps shows
wait_on_buffer after some errors with /home (can't stat file...). I
need to reboot to free disk2. Try a 2nd time and again a problem. I
run fsck on hdb and it fixes some errors. I start to copy again and
this time I go dir by dir on / and I copy all of /home with no
problems. However the error comes back again and again in random
places. Sometimes even while copying an empty dir. I also discover
that some dir's that did appear to complete successfully are in fact
missing many files.

I reformat disk2's partitions to be ext2 instead of ext3. This time
copying proceeds perfectly until /var. Now cp hangs again but this
time with get_request in ps.

So I am not sure if A)this is a bad drive, B)the Mac changed the
firmware of the drive somehow. C)Problem  in linux kernel.

Please advise me what I can do to further test/fix this. I will try to
format this in fat32 to use with windows 98 to see if I can eliminate
some possibilities though I doubt that will be helpful.

-Thanks,
Elie.

