Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTHHKLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHHKLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:11:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:35044 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S271152AbTHHKLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:11:21 -0400
Date: Sat, 09 Aug 2003 12:12:48 +0200
To: linux-kernel@vger.kernel.org
Subject: Readonly mounted ext2 filesystem partition changeable: Bug or Feature?
Content-Type: text/plain; charset=iso-8859-15; format=flowed
From: csg <chr@abelard.de>
Organization: Abelard
MIME-Version: 1.0
Message-ID: <oprtmunmkc06yy9w@smtp.1und1.com>
User-Agent: Opera7.11/Linux M2 build 406
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PLEASE copy any answer to this posting to
    chr@abelard.de
Thanks.]

Hello,

Short: I have seen changes made to a readonly mounted ext2 filesystem by
communicating with /sbin/init via /dev/initctl. This strange behaviour
goes away while moving /dev into RAM by using DEVFS.

In my opinion this is a bug. Or is it a feature?

**********************

Szenario:

System: Linux debian30 2.4.18-1-k6 #1 Fri Jun 6 23:55:12 EST 2003 i586 unknown
        IDE disk

I have made 1 readonly ROOT-partition including /dev (and some symbolic links)
and 1 read-write VAR-partition (without exec permission).

Then I created MD5SUM over the entire readonly partition, put the checksum
along with a check-script on a (later) write-protected floppy. Now on every reboot the floppy will be mounted and the check-script compares the saved checksum with the one created on the fly over the current partition.

After rebooting or calling something like "init <new runlevel>" the partition
was found altered. "cmp" / "diff" in front to a reference pointed out the
change was made in mid of data region of the ext2-filesystem.
(Not in metedata, therefore no "mount-count"-problem; of course: no journal.)

The problem goes ahead if

 - I do remove /dev/initctl
   (Of course, the system is now no longer able to shutdown correctly
   or to change the runlevel)
   or
   - I do switch to DEVFS which moves /dev and /dev/initctl to RAM.

I find this strange.
The expected behaviour would be to output an error message like
"Permission denied: Can not write to read-only filesystem".

So I think, it is a bug. But I'm not sure: May be it is a feature?

Thanks for your answer.

Christian Schmidt-Guetter



-- 
Christian Schmidt-Guetter
Email:   chr@abelard.de


