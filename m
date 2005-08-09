Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVHIVaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVHIVaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVHIVaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:30:14 -0400
Received: from mx.winch-hebergement.net ([82.196.5.104]:27045 "EHLO
	mx.ifrance.com") by vger.kernel.org with ESMTP id S964985AbVHIVaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:30:13 -0400
Message-ID: <42F91FC2.3010305@winch-hebergement.net>
Date: Tue, 09 Aug 2005 23:27:30 +0200
From: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs 3.6 + quota enabled, crash on delete (or maybe truncate)
References: <42F27161.2020702@winch-hebergement.net> <42F33379.5030804@namesys.com>
In-Reply-To: <42F33379.5030804@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Would you, please, try to reproduce the problem having reiserfs check 
> mode on.
> (it is File systems->Reiserfs support->Enable reiserfs debug mode in 
> kernel configuration)
> and with attached patch.

Here is the error log with reiserfs check mode on + patch applied :

ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: warning: CONFIG_REISERFS_CHECK is set ON
ReiserFS: sda3: warning: - it is slow mode for debugging.
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: journal-1153: found in header: first_unflushed_offset 
4607, last_flushed_trans_id 401988
ReiserFS: sda3: journal-1206: Starting replay from offset 
1726529608356351, trans_id 0
ReiserFS: sda3: journal-1299: Setting newest_mount_id to 23
ReiserFS: sda3: Using r5 hash to sort names
ReiserFS: sda3: warning: vs-8301: reiserfs_kmalloc: allocated memory 202992
[..a few days later..]
REISERFS: panic (device Null superblock): vs-8025: set_entry_sizes: 
(mode==c, insert_size==-4958), invalid length of directory item
Kernel panic - not syncing: REISERFS: panic (device Null superblock): 
vs-8025: set_entry_sizes: (mode==c, insert_size==-4958
), invalid length of directory item

The partition had just been checked with reiserfsck (2 days before) and 
it was ok. I didnt reboot between the reiserfsck and the crash.

Here was the result of reiserfsck before the crash:
Checking internal tree..finished
Comparing bitmaps..finished
Checking Semantic tree:
finished
No corruptions found
There are on the filesystem:
         Leaves 423085
         Internal nodes 2932
         Directories 1046685
         Other files 8739829
         Data block pointers 75038187 (0 of them are zero)
         Safe links 0
###########

Btw, i forgot to mention the mount options:
noatime,notail,usrquota


I just applied the patch submitted by Jan Kara:
http://bugzilla.kernel.org/show_bug.cgi?id=4771#c3
I dont know yet if it solves the problem :)

Best Regards,

Guillaume Pelat
