Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUEHRuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUEHRuo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbUEHRuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 13:50:44 -0400
Received: from ns.clanhk.org ([69.93.101.154]:26314 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S263893AbUEHRub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 13:50:31 -0400
Message-ID: <409D1D86.6050907@clanhk.org>
Date: Sat, 08 May 2004 12:48:54 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AMD64 and RAID6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the following in my dmesg:

raid5: measuring checksumming speed
  generic_sse:  6604.000 MB/sec
raid5: using function: generic_sse (6604.000 MB/sec)
raid6: int64x1   1847 MB/s
raid6: int64x2   2753 MB/s
raid6: int64x4   2878 MB/s
raid6: int64x8   1902 MB/s
raid6: sse2x1    1015 MB/s
raid6: sse2x2    1488 MB/s
raid6: sse2x4    1867 MB/s
raid6: using algorithm sse2x4 (1867 MB/s)
md: raid6 personality registered as nr 8
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

Why doesn't RAID6 use the int64x4 algorithm in this situation?  What is 
the motivation of setting the 'prefer field' on the sse algorithms and 
not on the integer based algorithms?

 From drivers/md/raid6.h:
/* Routine choices */
struct raid6_calls {
        void (*gen_syndrome)(int, size_t, void **);
        int  (*valid)(void);    /* Returns 1 if this routine set is 
usable */
        const char *name;       /* Name of this routine set */
        int prefer;             /* Has special performance attribute */
};

-ryan
